
module adder
#(parameter WIDTH = 4)
(
    input logic [WIDTH-1:0] a,
    input logic [WIDTH-1:0] b,
    output logic [WIDTH-1:0] sum,
    output logic cout
);
    // ? In-class, Active Learning Exercise: https://washu-cse2600-fl25.github.io/studios/studio04b#multi-bit-addition

    // TODO: Create a WIDTH-bit ripple carry adder using the `fulladder` modules and `generate` loops
    // ! You must use structural modeling via instances of the `fulladder` from Homework 3A
    assign sum = 0;  // FIXME!
    assign cout = 0; // FIXME!



endmodule
   // ! Spoiler Alert solution below (scroll)










































    // ? Solution below:
    // logic [WIDTH:0] carry_in;
    // assign carry_in[0] = 1'b0;

    //    // Loop to instantiate adders
    // generate
    //     genvar i;
    //     for(i=0;i<WIDTH;i=i+1) begin : adder_gen
    //         //assign carry_in[i+1] = carry_in[i];
    //         fulladder inst (.a(a[i]), .b(b[i]), .cin(carry_in[i]), .sum(sum[i]), .cout(carry_in[i+1]) );
    //     end
    // endgenerate

    // assign cout = carry_in[WIDTH];

