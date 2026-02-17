
module fulladder_tb();
    logic a,b,cin, sum, cout;
    logic error, expected_sum, expected_cout;
    integer i;
    integer error_count;
    fulladder dut(
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        error = 0;
        error_count = 0;
        $dumpfile("fulladder_tb.vcd");
        $dumpvars(0, fulladder_tb);
        // for loop that counts up to 8
        for(i=0;i<8;i=i+1) begin
            // assign a,b,cin to i[2:0]
            a = i[2];
            b = i[1];
            cin = i[0];
            {expected_cout, expected_sum} = a+b+cin;
            // wait for 1ns
            #1;
            error = sum===expected_sum && cout===expected_cout ? 0 : 1;
            if(error) begin
                error_count = error_count + 1;
                $display("Error: a=%b, b=%b, cin=%b, sum=%b, cout=%b, expected_sum=%b, expected_cout=%b", a, b, cin, sum, cout, expected_sum, expected_cout);
            end
            // print out the values of a,b,cin,sum,cout
            $display("a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
        end
              // Check all expected values
      if(error_count !== 0) begin
          $error("*** %d of %d tests failed! ***", error_count, 8);
      end
      else begin
          $display("fulladder_tb.sv:01:All tests passed!");
      end
      #10 $finish;
    end
endmodule
