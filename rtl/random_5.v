module random_5(
    input	lcd_pclk,
	input	clk_100,
    input	rst_n,
    output 	reg [4:0] q
);

	reg [4:0] taps = 5'b10100;
	// reg [4:0] taps = 5'b1;
	
	always @(posedge clk_100 or negedge rst_n) begin
        if(!rst_n) 
			q <= 5'h1;
        else 
			q <= {q[0] ^ 1'b0, q[4:1] ^ (taps[3:0] & {4{q[0]}})};
    end
	
endmodule