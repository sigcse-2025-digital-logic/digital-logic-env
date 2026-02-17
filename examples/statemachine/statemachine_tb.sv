
module statemachine_tb();

    logic clk;
    logic reset;
    logic out;
    statemachine dut(clk, reset, out);  // TODO: This may need to be updated!
        integer i;

    initial begin
        $dumpfile("statemachine_tb.vcd");
        $dumpvars(0, dut);

        // reset = 1;
        // #10;
        // reset = 0;
        // #10;

        // TODO: Create a test that checks your work
        for(i=0;i<10;i=i+1) begin
            clk = 1'b0;
            #10;
            clk = 1'b1;
            #10;
            if(out == 0)
            begin
                $error("Bad output! Expected 1");
            end

            clk = 1'b0;
            #10;
            clk = 1'b1;
            #10;
            if(out == 1)
            begin
                $error("Bad output!  Expected 0");
            end

            clk = 1'b0;
            #10;
            clk = 1'b1;
            #10;
            if(out == 1)
            begin
                $error("Bad output!  Expected 0");
            end
        end


        #10 $finish;
    end
endmodule
