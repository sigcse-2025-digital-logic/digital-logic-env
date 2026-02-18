module simple_comb(
    input  logic a,
    input  logic b,
    input  logic c,
    output logic y
);
// TODO: Create a **behavioral** model of the given circuit for the truth table
// TODO: using the **cannonical sum-of-products** form.:
// TODO:  a b c | y
// TODO:  ------+---
// TODO:  0 0 0 | 0
// TODO:  0 0 1 | 1
// TODO:  0 1 0 | 0
// TODO:  0 1 1 | 0
// TODO:  1 0 0 | 1
// TODO:  1 0 1 | 0
// TODO:  1 1 0 | 0
// TODO:  1 1 1 | 0
// ! This should be super simple --- one line.  There's no need to simplify / etc.
// ! Short tutorial on Verilog operators at: https://alchitry.com/tutorials/verilog/verilog-operators/
// ! and Verilog expressions: https://verilogams.com/quickref/expressions.html
    assign y = a & b;  // FIXME



endmodule
    // ! Spoiler Alert solution below (scroll)



































    // ? Solution below:
    // assign y = ~a & ~b & c | a & ~b & ~c;

    // OR structural:

    // wire _a, _b, _c;
    // not(_a, a);
    // not(_b, b);
    // not(_c, c);
    // wire term1, term2, result;
    // and(term1, _a, _b, c);
    // and(term2, a, _b, _c);
    // or(result, term1, term2);
    // assign y = result;
