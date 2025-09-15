
// 用於分辨並回傳LCD螢幕的規格
module rd_id(
	input clk,
	input rst_n,
	input [23:0] lcd_rgb,
	output reg [15:0] lcd_id
);
	reg [7:0] rd_flag;
	
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			rd_flag <= 8'd0;
			lcd_id <= 16'd0;
		end
		else begin
			rd_flag <= {rd_flag[6:0],1'b1}; // 把flag左移並在右邊接上1
			
			if(rd_flag == 8'h3f) begin // 代表過了6個cycle的意思(flag == 8'b00111111)
				case({lcd_rgb[7],lcd_rgb[15],lcd_rgb[23]})
					3'b000 : lcd_id <= 16'h4342;    //4.3' RGB LCD  RES:480x272
					3'b001 : lcd_id <= 16'h7084;    //7'   RGB LCD  RES:800x480
					3'b010 : lcd_id <= 16'h7016;    //7'   RGB LCD  RES:1024x600
					3'b100 : lcd_id <= 16'h4384;    //4.3' RGB LCD  RES:800x480
					3'b101 : lcd_id <= 16'h1018;    //10'  RGB LCD  RES:1280x800
					default : lcd_id <= 16'h4342;
				endcase
			end
		end
		
	end
endmodule