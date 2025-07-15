module update_tb;
    logic clk;
    logic rst;
    logic [7:0] detail_cofficient;
    logic [7:0] even_input;
    logic       even_valid;     
    logic       valid_coarseout;
    logic [7:0] coarse_coefficients;

    update dut (.*);

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end
 
    initial begin
        rst = 1;
        detail_cofficient = 8'd0;
        even_input = 8'd0;
        even_valid = 0;
        valid_coarseout = 0;

        #10;
        rst = 0;

        @(posedge clk);
        detail_cofficient = 8'd40;
        even_input = 8'dx;
        even_valid = 0;
        valid_coarseout = 0; 
        
        @(posedge clk);
        detail_cofficient = 8'dx;
        even_input = 8'd6;
        even_valid = 1;
        valid_coarseout = 0;

        @(posedge clk);
        valid_coarseout = 1;
        detail_cofficient = 8'd81;
        even_input = 8'dx;
        even_valid = 0;

        @(posedge clk);
        valid_coarseout = 0;
        detail_cofficient = 8'dx;
        even_input = 8'd3;
        even_valid = 1;

        @(posedge clk);
        detail_cofficient = 8'd6;
        even_input = 8'dx;
        even_valid = 0;
        valid_coarseout = 1;
       
        #10;
        $finish;
    end
endmodule
