module top(
    output logic tm_strobe,      // TM1638 Strobe
    output logic tm_clock,       // TM1638 Clock
    inout  logic tm_dio          // TM1638 Data
);

    // ***** Leave the part below (everything above the "TODO" area) alone
    // 6MHz clock
    logic clock;
    SB_HFOSC #(.CLKHF_DIV("0b11")) inthosc(.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clock));

    // Startup reset for one clock
    logic reset = 1;
    always_ff @(posedge clock) begin
        reset = 0;
    end


   logic [7:0] display0, display1, display2, display3, display4, display5, display6, display7, leds;
   logic [7:0] keys;

    logic [7:0] digits [0:15];
    logic [7:0] eq;
    logic [7:0] lplus;
    logic [7:0] rplus;


    logic [3:0] sum;
    logic cout;

    //    +-a-+
    //    |   |
    //    f   b
    //    |   |
    //    +-g-+
    //    |   |
    //    e   c
    //    |   |
    //    +-d-+ h
    //

                //        hgfe dcba
    assign digits[0] = 8'b0011_1111; // 0
    assign digits[1] = 8'b0000_0110; // 1
    assign digits[2] = 8'b0101_1011; // 2
    assign digits[3] = 8'b0100_1111; // 3
    assign digits[4] = 8'b0110_0110; // 4
    assign digits[5] = 8'b0110_1101; // 5
    assign digits[6] = 8'b0111_1101; // 6
    assign digits[7] = 8'b0000_0111; //7
                //         hgfe dcba
    assign digits[8] =  8'b0111_1111; //8
    assign digits[9] =  8'b0110_0111; //9
    assign digits[10] = 8'b0111_0111; //A
    assign digits[11] = 8'b0111_1100; //b
    assign digits[12] = 8'b0011_1001; //C
    assign digits[13] = 8'b0101_1110; //d
    assign digits[14] = 8'b0111_1001; //E
    assign digits[15] = 8'b0111_0001; //F
    assign eq         = 8'b0100_1000; // =
    assign lplus      = 8'b0100_0110; // -|
    assign rplus      = 8'b0111_0000; // |-


    // // ************************************************
    ledandkey ledAndKey(.clock(clock), .reset(reset),
                        .tm_strobe(tm_strobe), .tm_clock(tm_clock), .tm_dio(tm_dio),
                        .display0(display0),
                        .display1(display1),
                        .display2(display2),
                        .display3(display3),
                        .display4(display4),
                        .display5(display5),
                        .display6(display6),
                        .display7(display7),
                        .leds(leds),
                        .keys(keys));

    assign display0 = digits[sum];
    assign display1 = 0;
    assign display2 = eq;
    assign display3 = 0;
    assign display4 = digits[keys[3:0]];
    assign display5 = rplus;
    assign display6 = lplus;
    assign display7 = digits[keys[7:4]];
    assign leds = {6'b0, cout, 1'b0};

    adder #( .WIDTH(4)) dut(
        .a(keys[3:0]),
        .b(keys[7:4]),
        .sum(sum),
        .cout(cout)
    );


endmodule
