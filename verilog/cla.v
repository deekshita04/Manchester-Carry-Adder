module carry_lookahead_adder(
    input [3:0] A,     
    input [3:0] B,     
    input Cin,         
    output [3:0] Sum,  
    output Cout        
);

    wire [3:0] G;  
    wire [3:0] P;  
    wire [3:0] C;  
    
    assign G = A & B;  
    assign P = A ^ B;  

    
    assign C[0] = Cin;
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);

    
    assign Sum = P ^ C[3:0]; 
    assign Cout = G[3] | (P[3] & C[3]);

endmodule


module carry_lookahead_adder_tb;

    // Inputs
    reg [3:0] A;
    reg [3:0] B;
    reg Cin;

    // Outputs
    wire [3:0] Sum;
    wire Cout;

    // Instantiate the Carry Look-Ahead Adder module
    carry_lookahead_adder uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    // Test procedure
    initial begin
        // Display header
        $display("A     B     Cin | Sum   Cout");
        $display("----------------|-------------");

        // Test cases
        A = 4'b0000; B = 4'b0000; Cin = 1'b0; #10;
        $display("%b %b %b   | %b %b", A, B, Cin, Sum, Cout);

        A = 4'b0001; B = 4'b0010; Cin = 1'b0; #10;
        $display("%b %b %b   | %b %b", A, B, Cin, Sum, Cout);

        A = 4'b0101; B = 4'b0011; Cin = 1'b0; #10;
        $display("%b %b %b   | %b %b", A, B, Cin, Sum, Cout);

        A = 4'b1111; B = 4'b0001; Cin = 1'b0; #10;
        $display("%b %b %b   | %b %b", A, B, Cin, Sum, Cout);

        A = 4'b1010; B = 4'b0101; Cin = 1'b1; #10;
        $display("%b %b %b   | %b %b", A, B, Cin, Sum, Cout);

        A = 4'b1111; B = 4'b1111; Cin = 1'b1; #10;
        $display("%b %b %b   | %b %b", A, B, Cin, Sum, Cout);

        // End of test
        //$stop;
        $finish;
    end

endmodule

