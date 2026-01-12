module adder_4bit (
    input [3:0] a, b,
    input cin,
    output [3:0] s,
    output cout
);

    wire c1, c2, c3;

    full_adder fa0 (
        .X(a[0]), 
        .Y(b[0]), 
        .Ci(cin), 
        .S(s[0]), 
        .Co(c1)
    );

    full_adder fa1 (
        .X(a[1]), 
        .Y(b[1]), 
        .Ci(c1), 
        .S(s[1]), 
        .Co(c2)
    );

    full_adder fa2 (
        .X(a[2]), 
        .Y(b[2]), 
        .Ci(c2), 
        .S(s[2]), 
        .Co(c3)
    );

    full_adder fa3 (
        .X(a[3]), 
        .Y(b[3]), 
        .Ci(c3), 
        .S(s[3]), 
        .Co(cout)
    );

endmodule
