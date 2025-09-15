module cloud(
    input	lcd_pclk,
	input	clk_100,
    input	rst_n,
    input	[10:0]  pixel_xpos,
    input	[10:0]  pixel_ypos, 
	input	[4:0] 	random_five,
	input	[2:0] 	random_three,
	input	is_living,
	input	[3:0] move_rate,

    output reg cloud_draw
);

	// === 定義雲朵形狀 ===
	reg [99:0] cloud_bitmap [17:0];
	initial begin
		cloud_bitmap[0]  <= 100'b0000000000_0000000000_0000000000_0000000000_0000000000_1111000000_0000000000_0000000000_0000000000_0000000000;
		cloud_bitmap[1]  <= 100'b0000000000_0000000000_0000000000_0000000000_0000000111_0000111110_0000000000_0000000000_0000000000_0000000000;
		cloud_bitmap[2]  <= 100'b0000000000_0000000000_0000000000_0000000000_0000111000_0000000111_1111100000_0000000000_0000000000_0000000000;
		cloud_bitmap[3]  <= 100'b0000000000_0000000000_0000000000_0000011111_1111000000_0000000011_0001111000_0000000000_0000000000_0000000000;
		cloud_bitmap[4]  <= 100'b0000000000_0000000000_0000000000_0000110000_0000000000_0000000000_0000000110_0000000000_0000000000_0000000000;
		cloud_bitmap[5]  <= 100'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000111_0000000000_0000000000_0000000000;
		cloud_bitmap[6]  <= 100'b0000000000_0000000000_0000000011_1111000000_0000000000_0000000000_0000001111_1111100000_0000000000_0000000000;
		cloud_bitmap[7]  <= 100'b0000000000_0000000000_0000001110_0000000000_0000000000_0000000000_0000110000_0111110000_0000000000_0000000000;
		cloud_bitmap[8]  <= 100'b0000000000_0000000000_0000000111_1000000000_0000000000_0000000000_0001000000_0000110000_0000000000_0000000000;
		cloud_bitmap[9]  <= 100'b0000000000_0000001111_1111111000_0000000000_0000000000_0000000000_0000000000_0000111000_0000000000_0000000000;
		cloud_bitmap[10] <= 100'b0000000000_0001111111_1111110000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
		cloud_bitmap[11] <= 100'b0000000000_0011110000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000110_0000000000_0000000000;
		cloud_bitmap[12] <= 100'b0000000000_0011111000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000011_1000000000_0000000000;
		cloud_bitmap[13] <= 100'b0000000000_0011110000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000011_1110000000_0000000000;
		cloud_bitmap[14] <= 100'b0111101111_1110000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000111111_1111000000_0000000000;
		cloud_bitmap[15] <= 100'b1000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0001111100_1111111000_0000000000;
		cloud_bitmap[16] <= 100'b1100000000_0000001111_0000000000_0000001111_0000000000_1111111111_0000000000_0000000000_0000001111_1111111111;
		cloud_bitmap[17] <= 100'b1111111100_0000001111_1111111111_1111111111_1111111111_1111111111_1111111111_1111111111_1111111111_1111111111;
	end
	
	// === 雲層參數 ===
	parameter CLOUD_H = 5'd18;
	parameter CLOUD_W = 7'd100;
	parameter BASE_H = 11'd100;
	
	// === 每朵雲所需的register(共3朵) ===
	reg [10:0] offset;
	reg [8:0] wait_counter;
    reg [8:0] wait_interval;
	reg [6:0] height_offset;
	reg to_draw;
	
	
	reg [10:0] offset_2;
	reg [8:0] wait_counter_2;
    reg [8:0] wait_interval_2;
	reg [6:0] height_offset_2;
	reg to_draw_2;
	
	reg [10:0] offset_3;
	reg [10:0] wait_counter_3;
    reg [10:0] wait_interval_3;
	reg [6:0] height_offset_3;
	reg to_draw_3;
	
	
	// === 更新雲朵位置 ===
	
	// 雲朵1
	always @(posedge clk_100 or negedge rst_n) begin
		if(!rst_n) begin
			offset <= 11'd0;
			wait_counter <= 9'd0;
			wait_interval <= 9'd0;
			height_offset <= 7'd0;
		end
		else if(is_living) begin
			if(offset == 11'd0) begin
				if(wait_counter == 9'd0) begin 
					wait_interval <= random_five * 4'd8;
					height_offset <= random_five * 3'd4;
					wait_counter <= 9'd1;	
				end
				else begin
					if(wait_counter >= wait_interval) begin
						offset <= move_rate / 2; 
						wait_counter <= 9'd0;
					end
					else 
						wait_counter <= wait_counter + 1;	
				end
			end		
			else if(offset >= 11'd800 + CLOUD_W) begin
				offset <= 11'd0;
			end
			else begin
				offset <= (offset + move_rate / 2) % (11'd800 + CLOUD_W);
			end
		end
	end
	
	// 雲朵2
	always @(posedge clk_100 or negedge rst_n) begin
		if(!rst_n) begin
			offset_2 <= 11'd0;
			wait_counter_2 <= 9'd0;
			wait_interval_2 <= 9'd0;
			height_offset_2 <= 7'd0;
		end
		else if(is_living) begin
			if(offset_2 == 11'd0) begin
				if(wait_counter_2 == 9'd0) begin 
					wait_interval_2 <= 9'd128 * 4'd4;
					height_offset_2 <= random_five * 3'd4;
					wait_counter_2 <= 9'd1;	
				end
				else begin
					if(wait_counter_2 >= wait_interval_2) begin
						offset_2 <= (move_rate / 2); 
						wait_counter_2 <= 9'd0;
					end
					else 
						wait_counter_2 <= wait_counter_2 + 1;	
				end
			end		
			else if(offset_2 >= 11'd800 + CLOUD_W) begin
				offset_2 <= 11'd0;
			end
			else begin
				offset_2 <= (offset_2 + move_rate / 2) % (11'd800 + CLOUD_W);
			end
		end
	end
	
	// 雲朵3
	always @(posedge clk_100 or negedge rst_n) begin
		if(!rst_n) begin
			offset_3 <= 11'd0;
			wait_counter_3 <= 9'd0;
			wait_interval_3 <= 9'd0;
			height_offset_3 <= 7'd0;
		end
		else if(is_living) begin
			if(offset_3 == 11'd0) begin
				if(wait_counter_3 == 9'd0) begin 
					wait_interval_3 <= 9'd150 + random_five * 5'd16 + random_three * 4'd4;
					height_offset_3 <= random_five * 3'd4;
					wait_counter_3 <= 9'd1;	
				end
				else begin
					if(wait_counter_3 >= wait_interval_3) begin
						offset_3 <= move_rate / 2;
						wait_counter_3 <= 9'd0;
					end
					else 
						wait_counter_3 <= wait_counter_3 + 1;	
				end
			end		
			else if(offset_3 >= 11'd800 + CLOUD_W) begin
				offset_3 <= 11'd0;
			end
			else begin
				offset_3 <= (offset_3 + move_rate / 2) % (11'd800 + CLOUD_W);
			end
		end
	end
	
	// === 繪圖邏輯 ===
	
	// 雲朵1
	always @(*) begin
		if(pixel_ypos <= (BASE_H + height_offset) && pixel_ypos > (BASE_H + height_offset) - CLOUD_H) begin
			to_draw = 1'b0;
			if((pixel_xpos >= ((offset < 11'd800) ? 11'd800 - offset : 11'd0)) && pixel_xpos < (11'd800 + CLOUD_W - offset)) begin
				to_draw = cloud_bitmap[pixel_ypos - ((BASE_H  + height_offset) - CLOUD_H)][pixel_xpos - (800 - offset)];
			end
		end
		else
			to_draw = 1'b0;		
	end
	
	// 雲朵2
	always @(*) begin
		if(pixel_ypos <= (BASE_H + height_offset_2) && pixel_ypos > (BASE_H + height_offset_2) - CLOUD_H) begin
			to_draw_2 = 1'b0;
			if((pixel_xpos >= ((offset_2 < 11'd800) ? 11'd800 - offset_2 : 11'd0)) && pixel_xpos < (11'd800 + CLOUD_W - offset_2)) begin
				to_draw_2 = cloud_bitmap[pixel_ypos - ((BASE_H  + height_offset_2) - CLOUD_H)][pixel_xpos - (800 - offset_2)];
			end
		end
		else
			to_draw_2 = 1'b0;		
	end
	
	// 雲朵3
	always @(*) begin
		if(pixel_ypos <= (BASE_H + height_offset_3) && pixel_ypos > (BASE_H + height_offset_3) - CLOUD_H) begin
			to_draw_3 = 1'b0;
			if((pixel_xpos >= ((offset_3 < 11'd800) ? 11'd800 - offset_3 : 11'd0)) && pixel_xpos < (11'd800 + CLOUD_W - offset_3)) begin
				to_draw_3 = cloud_bitmap[pixel_ypos - ((BASE_H  + height_offset_3) - CLOUD_H)][pixel_xpos - (800 - offset_3)];
			end
		end
		else
			to_draw_3 = 1'b0;		
	end
	
	
	always @(*) begin
		cloud_draw = to_draw | to_draw_2 | to_draw_3;
	end
	
endmodule