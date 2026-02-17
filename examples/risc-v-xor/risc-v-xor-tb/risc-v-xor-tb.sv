module testbench();

  integer error_count;
  integer fd, ret;
  integer total_tests;

  // Include the register definitions (to use syymbolic names in test cases)
  `include "../../../common/risc-v-regs.sv"

  // Device to test and related signals
  logic        clock = 0, reset = 0;  // inputs
  logic [31:0] PC; //output
  logic [31:0] Instr = 0 ; // Input
  logic        MemWrite; // Output
  logic [31:0] ALUResult, WriteData; // Output
  logic [31:0] ReadData = 0; // Input
  logic [31:0] origPC = 0;
  logic [4:0] rd;
  logic [4:0] rs1;
  logic [11:0] imm;
  logic [31:0] rs_init;
  logic [31:0] expected_pc;
  riscvsingle dut(clock,reset, PC, Instr, MemWrite, ALUResult, WriteData, ReadData);

  task reset_dut;
      clock = 0;
      reset = 1; #10;
      clock = 1; #10;
      reset = 0; #10;
      clock = 1; #10;
      clock = 0; #10;
  endtask


  task check_xor;
    input string name;
    input logic [4:0] rd;
    input logic [4:0] rs1;
    input logic [4:0] rs2;
    input logic [31:0] rs1_init;
    input logic [31:0] rs2_init;
    input logic [31:0] rd_init;

    logic [31:0] initial_pc;
    logic [31:0] expected_rd;

  begin
    reset_dut();
    // Arbitrary PC start value
    initial_pc = 32'h00000020;
    dut.dp.pcreg.q = initial_pc;

    // Initialize registers
    dut.dp.rf.rf[rs1] = rs1_init;
    dut.dp.rf.rf[rs2] = rs2_init;
    dut.dp.rf.rf[rd] = rd_init; // reg[rd] = init value

    // Set the instruction to be a LUI
    Instr = { 7'b0000000, rs2, rs1, 3'b100, rd,  7'b0110011};
    #10;
    // Clock cycle
    clock = 1; #10;

    total_tests = total_tests + 3;

    // Check all elements of stat that could resonably be changed:  Final PC, final rd, and memory

    // Confirm that memory is not written
    assert(MemWrite == 0) else
    begin
      error_count = error_count + 1;
      $error("%s - Memory was changed!", name);
    end
    clock = 0; #10;

    // Check the PC is ok
    assert(dut.dp.pcreg.q == initial_pc+4) else
    begin
      error_count = error_count + 1;
      $error("%s - PC is not correct!", name);
    end

    // Check that rd has the expected results
    expected_rd = rs1_init ^ rs2_init;
    assert(dut.dp.rf.rf[rd] == expected_rd) else
    begin
      error_count = error_count + 1;
      $error("%s - Reg[rd] is not correct! Expected %X, got %X", name, expected_rd, dut.dp.rf.rf[rd]);
    end
  end
  endtask


  task check_xori;
    input string name;
    input logic [4:0] rd;
    input logic [4:0] rs1;
    input logic [11:0] imm;
    input logic [31:0] rs1_init;
    input logic [31:0] rd_init;

    logic [31:0] initial_pc;
    logic [31:0] expected_rd;

  begin
    reset_dut();
    // Arbitrary PC start value
    initial_pc = 32'h00000020;
    dut.dp.pcreg.q = initial_pc;

    // Initialize registers
    dut.dp.rf.rf[rs1] = rs1_init;
    dut.dp.rf.rf[rd] = rd_init; // reg[rd] = init value

    // Set the instruction to be a LUI
    Instr = { imm, rs1, 3'b100, rd,  7'b0010011};
    #10;
    // Clock cycle
    clock = 1; #10;

    total_tests = total_tests + 3;

    // Check all elements of stat that could resonably be changed:  Final PC, final rd, and memory

    // Confirm that memory is not written
    assert(MemWrite == 0) else
    begin
      error_count = error_count + 1;
      $error("%s - Memory was changed!", name);
    end
    clock = 0; #10;

    // Check the PC is ok
    assert(dut.dp.pcreg.q == initial_pc+4) else
    begin
      error_count = error_count + 1;
      $error("%s - PC is not correct!", name);
    end

    // Check that rd has the expected results
    expected_rd = rs1_init ^ {{20{imm[11]}}, imm};
    assert(dut.dp.rf.rf[rd] == expected_rd) else
    begin
      error_count = error_count + 1;
      $error("%s - Reg[rd] is not correct! Expected %X, got %X", name, expected_rd, dut.dp.rf.rf[rd]);
    end
  end
  endtask


  // initialize test
  initial
    begin
      $dumpfile("risc-v-xor-tb.vcd");
      $dumpvars(0, testbench);
      error_count = 0;
      total_tests = 0;

      check_xor("xor t0, t1, t2",t0,t1,t2, 32'h1, 32'h0, 32'hBAD0BAD0);
      check_xor("xor a0, t1, t4",a0,t1,t4, 32'hF5F5, 32'hFF55F5F, 32'hBAD0BAD0);
      check_xor("xor sp, t1, t4",sp,t1,t4, 32'h55555555, 32'hAAAAAAAA, 32'hBAD0BAD0);
      check_xor("xor s0, s1, s4",s0,s1,s4, 32'hAAAAAAAA, 32'h55555555, 32'hBAD0BAD0);

      check_xori("xori t0, t1, 12",t0,t1, 12'h1,  32'h0, 32'hBAD0BAD0);
      check_xori("xori t0, t1, FFF",t0,t1, 12'hFFF,  32'h0, 32'hBAD0BAD0);

      // Summarize results
      if(error_count !== 0) begin
          $error("*** %d of %d tests failed! ***", error_count, total_tests);
      end
      else begin
          $display("risc-v-xor-tb.sv:01:All tests passed!");
      end
      // $fclose(fd);
      $finish;
    end
endmodule
