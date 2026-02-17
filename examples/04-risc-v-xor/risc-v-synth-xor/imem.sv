module imem(input  logic [31:0] address,
            output logic [31:0] instruction);

  logic [31:0] ROM[0:255];

  initial
      $readmemh("../risc-v-xor-test/products/xor_driver_hardware.rom.txt",ROM);

  assign instruction = ROM[address[9:2]]; // word aligned

endmodule
