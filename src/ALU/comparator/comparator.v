`timescale 1ns / 1ps

module comparator(
    input wire[7:0] A,
    input wire[7:0] B,
    input wire sign,
    output wire eq,
    output wire lt,
    output wire gt
);
    wire[7:0] _eq;
    wire[7:0] _gt;
    wire sign_comparison;
    
    generate
        for (genvar i = 0; i < 8; i = i + 1) begin
            assign _eq[i] = A[i] ~^ B[i];
        end
        
        for (genvar i = 0; i < 8; i = i + 1) begin
            if (i == 7) begin
                assign _gt[i] = A[7] & ~B[7];
            end
            else begin
                assign _gt[i] = _eq[i+1] & (A[i] & ~B[i]);
            end
        end
    endgenerate
    
    assign sign_comparison = ((~A[7] & B[7]) | |_gt) ^ (A[7] & ~B[7]);
    assign eq = &_eq;
    assign gt = (~sign & |_gt) | (sign & sign_comparison);
    assign lt = ~(eq | gt);
endmodule
