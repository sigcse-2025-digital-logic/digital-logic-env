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

    // LED & Key I/O board signals
   logic [7:0] display0, display1, display2, display3, display4, display5, display6, display7, leds;
   logic [7:0] keys;
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

    assign display0[6:0] = q ? {7{1'b1}} : 0;
    assign display0[7] = keys[0];
    assign display1 = {keys[1], 7'b0};
    assign display2 = 0;
    assign display3 = 0;
    assign display4 = 0;
    assign display5 = 0;
    assign display6 = 0;
    assign display7 = 0;
    assign leds = 0;

    logic q;
    logic manual_reset, manual_clk;
    statemachine dut(
        .reset(manual_reset),
        .clk(manual_clk),
        .q(q)
    );

    risingedge_detector clk_press(.in(keys[0]), .detected(manual_clk), .clock(clock), .reset(reset));
    risingedge_detector reset_press(.in(keys[1]), .detected(manual_reset), .clock(clock), .reset(reset));

endmodule
