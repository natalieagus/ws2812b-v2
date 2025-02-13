module pixel_reverse #(
    parameter integer ROW_DIM = 8,
    parameter integer COL_DIM = 8
)(
    input  wire [$clog2(ROW_DIM*COL_DIM)-1:0] pixel_in, 
    output wire [$clog2(ROW_DIM*COL_DIM)-1:0] pixel_out
);

    // Number of bits for row and column indices
    localparam ROW_BITS = $clog2(ROW_DIM);
    localparam COL_BITS = $clog2(COL_DIM);

    // Break down the input pixel address into (row_in, col_in)
    wire [ROW_BITS-1:0] row_in;
    wire [COL_BITS-1:0] col_in;

    // row_in = pixel_in / COL_DIM
    // col_in = pixel_in % COL_DIM
    // In Verilog, use division and modulus carefully for synthesis,
    // but most tools will handle these for constant powers of two.
    assign row_in = pixel_in / COL_DIM;  // or pixel_in[?:COL_BITS] if COL_DIM is a power of 2
    assign col_in = pixel_in % COL_DIM;  // or pixel_in[COL_BITS-1:0] if COL_DIM is a power of 2

    // Reverse column index if row is odd
    wire [COL_BITS-1:0] col_rev;
    assign col_rev = (row_in[0] == 1'b1)
                     ? (COL_DIM - 1 - col_in)
                     : col_in;

    // Reconstruct the output pixel index
    assign pixel_out = row_in * COL_DIM + col_rev;

endmodule
