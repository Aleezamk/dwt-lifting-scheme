module update (
    input  logic        clk,
    input  logic        rst,
    input  logic [7:0]  detail_cofficient,  
    input  logic [7:0]  even_input,        // Even input for addition
    input  logic        even_valid,        // Valid signal for even_input
    input  logic        valid_coarseout,   // Valid signal for coarse coefficients
    output logic [7:0]  coarse_coefficients // Final output
);
 
    logic [7:0] shifted_data;
    logic [7:0] d3_out;       // Output of D3  
    logic [7:0] d4_out;       // Output of D4  
    logic [7:0] sum; 

    // Combinational logic: Right shift by 2
    always_comb begin
        shifted_data = detail_cofficient >> 2;
    end

    // D3 Flip-Flop: stores shifted_data
    always_ff @(posedge clk) begin
        if (rst)
            d3_out <= 8'd0;
        else
            d3_out <= shifted_data;
    end

    // Combinational sum
    always_comb begin
        if (even_valid)
            sum = even_input + d3_out;
    end

    // D4 Flip-Flop: stores sum
    always_ff @(posedge clk) begin
        if (rst)
            d4_out <= 8'd0;
        else 
            d4_out <= sum;
    end

    // Register output only on valid_coarseout
    always_comb  begin
        if (rst)
            coarse_coefficients = 8'd0;
        else if (valid_coarseout)
            coarse_coefficients = shifted_data + d4_out;
    end

endmodule
