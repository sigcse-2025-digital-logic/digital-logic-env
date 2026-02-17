module fulladder(
    input logic a,b,cin,
    output logic sum,cout
);
    // TODO: Complete the code for a full adder (behavioral model!)
    assign sum = 0;  // FIXME!
    assign cout = 0; // FIXME!

endmodule
    // ! Spoiler Alert solution below (scroll)

















































    // ? Solution below:
    // Solution 1:
    // assign sum = a ^ b ^ cin;
    // assign cout = (a & b) | (a & cin) | (b & cin);

    // Solution 2
    // assign {cout, sum} = a + b + cin;
