
module statemachine_tb();
    // ? Basec on an In-class, Active Learning Exercise: https://washu-cse2600-fl25.github.io/studios/studio04b#state-machines
    // ? (Test below is simplified)

    logic clk;
    logic reset;
    logic out;
    statemachine dut(clk, reset, out);
    integer i;

    initial begin
        // ! The two lines below are done.  Do not change them
        $dumpfile("products/statemachine_tb.vcd");
        $dumpvars(0, dut);

        // ! The 4 lines below reset the state machine.
        reset = 1;
        #10;
        reset = 0;
        #10;


            if(out != 1)
            begin
                $error("Bad output! Expected 1 before first clock");
            end

            // Confirm that the output is 0 after the first clock
            // ! Example: A clock pulse (off 10 units of time, on 10 units of time)
            // ! Then check for the expected output
            clk = 1'b0;
            #10;
            clk = 1'b1;
            #10;
            if(out != 0)
            begin
                $error("Bad output! Expected 0 after first clock");
            end

            // TODO: Check the value after the 2nd clock

            // TODO: Check the value after the 3rd clock

        #10 $finish;
    end
endmodule
    // ! Spoiler Alert solution below (scroll)












            // ? Solution below:
            // TODO: Check the value after the 2nd clock
            // clk = 1'b0;
            // #10;
            // clk = 1'b1;
            // #10;
            // if(out != 0)
            // begin
            //     $error("Bad output!  Expected 0 after second clock");
            // end

            // TODO: Check the value after the 3rd clock
            // clk = 1'b0;
            // #10;
            // clk = 1'b1;
            // #10;
            // if(out != 1)
            // begin
            //     $error("Bad output!  Expected 1 after third clock");
            // end
