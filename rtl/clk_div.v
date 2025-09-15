module clk_div(
	input clk,
	input rst_n,
	input [15:0] lcd_id,
	output reg lcd_pclk,
	output reg clk_60
);

	reg clk_25m;
	reg clk_12_5m;
	reg div_4_cnt;
	
	// === 新增 60Hz 分頻器 ===
	reg [21:0] cnt_60hz;
	
	
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) 
			clk_25m <= 1'b0;
		else 
			clk_25m <= ~clk_25m;
	end
	
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			clk_12_5m <= 1'b0;
			div_4_cnt <= 1'b0;
		end
		else begin
			div_4_cnt <= div_4_cnt + 1'b1;
			if(div_4_cnt == 1'b1)
				clk_12_5m <= ~clk_12_5m;
		end
	end
	
	always @(*) begin
		case(lcd_id) 
			16'h4342 : lcd_pclk = clk_12_5m;
			16'h7084 : lcd_pclk = clk_25m;       
			16'h7016 : lcd_pclk = clk;
			16'h4384 : lcd_pclk = clk_25m;
			16'h1018 : lcd_pclk = clk;
			default :  lcd_pclk = 1'b0;
		endcase      
	end
	
	// === 新增 60Hz 分頻器 ===
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			clk_60 <= 1'b0;
			cnt_60hz <= 22'd0;
		end
		else if(cnt_60hz < 22'd416666) begin // 22'd416666
			cnt_60hz <= cnt_60hz + 1'b1;
		end
		else begin
			clk_60 <= ~clk_60;
			cnt_60hz <= 22'd0;
		end
	end

endmodule