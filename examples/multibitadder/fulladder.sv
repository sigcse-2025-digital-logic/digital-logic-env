module fulladder(
    input logic a,b,cin,
    output logic sum,cout
);
    // TODO: Complete the code for a full adder (behavioral model!)
    // assign sum = a ^ b ^ cin;
    // assign cout = (a & b) | (a & cin) | (b & cin);
    assign {cout, sum} = a + b + cin;
endmodule

























    // !  Alert:  Complete the code for a full adder (behavioral model!)
    // ? Query
    // * Highlight
    // Boring
