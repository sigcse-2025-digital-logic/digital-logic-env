module statemachine(
    input logic clk,
    input logic reset,
    output logic q  // Output is active only in the designated staet

);

// TODO: Complete the logic for:  the 3-state state machine covered in class; It should have an asynchronout reset

typedef enum logic [1:0] {S0, S1, S2} statetype;

statetype state, nextstate;
always_ff @(posedge clk, posedge reset)
    if(reset)   state <= S0;
    else        state <= nextstate;

always_comb
    case (state)
        S0: nextstate = S1;
        S1: nextstate = S2;
        S2: nextstate = S0;
        default: nextstate = S0;
    endcase

assign q = (state == S0);

endmodule
