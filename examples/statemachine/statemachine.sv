module statemachine(
    input logic clk,
    input logic reset,
    output logic q  // Output is active only in the designated state

);
// ? In-class, Active Learning Exercise: https://washu-cse2600-fl25.github.io/studios/studio04b#state-machines

// ! DONE:  The state machine is done
// ! S0 is the accepting state/output state.  `q` should be 1 every third clock: S0 (q=1), then S1, then S2, then S0 (q=1), etc.
typedef enum logic [1:0] {S0, S1, S2} statetype;
statetype state, nextstate;

// Determine next state based on current state
always_comb
    case (state)
        S0: nextstate = S1;
        S1: nextstate = S2;
        S2: nextstate = S0;
        default: nextstate = S0;
    endcase

// One clock edges or reset, update the state
always_ff @(posedge clk, posedge reset)
    if(reset)   state <= S0;
    else        state <= nextstate;

// Update the output if in the accepting state
assign q = (state == S0);

endmodule
