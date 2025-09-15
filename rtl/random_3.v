module random_3(
    input lcd_pclk,  
	input clk_100,
    input rst_n,          
    output reg [2:0] q    
);

    always @(posedge clk_100 or negedge rst_n) begin
        if (!rst_n)
            q <= 3'b001;
        else begin
            q[0] <= q[2];
            q[1] <= q[0];
            q[2] <= q[2] ^ q[1];
        end
    end

endmodule
