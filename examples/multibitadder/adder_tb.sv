module adder_tb
#(parameter WIDTH = 5)
();

    logic [WIDTH-1:0] a;
    logic [WIDTH-1:0] b;
    logic [WIDTH-1:0] sum;
    logic cout;

    logic error;
    logic [WIDTH-1:0] expected_sum;
    logic expected_cout;

    integer i;
    integer error_count;
    integer test_count;
    integer max_value;
    adder #( .WIDTH(WIDTH))
    dut(
        .a(a),
        .b(b),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        error = 0;
        error_count = 0;
        test_count = 0;
        max_value = 1<<(2*WIDTH);
        $dumpfile("adder_tb.vcd");
        $dumpvars(0, adder_tb);
        // for loop that counts through all values
        for(i=0;i<max_value;i++) begin
            // assign a,b,cin to i[2:0]
            a = i[WIDTH-1:0];
            b = i[2*WIDTH-1:WIDTH];
            {expected_cout, expected_sum} = a+b;
            // wait for 1ns
            #1;
            error = sum===expected_sum && cout===expected_cout ? 0 : 1;
            if(error) begin
                error_count = error_count + 1;
                $display("Error: a=%b, b=%b,  sum=%b, cout=%b, expected_sum=%b, expected_cout=%b", a, b, sum, cout, expected_sum, expected_cout);
            end
            // print out the values of a,b,cin,sum,cout
            $display("a=%b, b=%b,  sum=%b, cout=%b", a, b, sum, cout);
            test_count = test_count + 1;
        end
              // Check all expected values
      if(error_count !== 0) begin
          $error("*** %d of %d tests failed! ***", error_count, test_count);
      end
      else begin
          $display("adder_tb.sv:01:All tests passed!");
      end
      #10 $finish;
    end
endmodule
