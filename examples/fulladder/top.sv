module top(
    output logic led_nr,
    output logic led_ng,
    output logic led_nb,
    input logic switch_1,
    input logic switch_2,
    input logic switch_3
    );

    // The below configures how the pins on the iCE40 / UPduino are connected to signals in our logic
    // verilator lint_off PINMISSING
    // verilator lint_off ASSIGNIN
    logic nSw1, nSw2, nSw3;
    SB_IO #(.PIN_TYPE(6'b000001),.PULLUP(1'b1)) sw1inst(.PACKAGE_PIN(switch_1),.D_IN_0(nSw1));
    SB_IO #(.PIN_TYPE(6'b000001),.PULLUP(1'b1)) sw2inst(.PACKAGE_PIN(switch_2),.D_IN_0(nSw2));
    SB_IO #(.PIN_TYPE(6'b000001),.PULLUP(1'b1)) sw3inst(.PACKAGE_PIN(switch_3),.D_IN_0(nSw3));

    // Create positive logic variations of all signals
    logic red, green, blue;
    assign led_nr = ~red;
    assign led_nb = ~blue;
    assign led_ng = ~green;

    logic sw1, sw2, sw3;
    assign sw1 = ~nSw1;
    assign sw2 = ~nSw2;
    assign sw3 = ~nSw3;

    // Connect to full adder
    fulladder adder(.a(sw1), .b(sw2), .cin(sw3), .sum(green), .cout(blue));
endmodule
