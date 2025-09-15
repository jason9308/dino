module score(
	input	clk_100,
    input	rst_n,
	input	[10:0]  pixel_xpos,
	input	[10:0]  pixel_ypos,
	input	is_living,
	
	output	score_draw
);
	
	// === 定義數字圖像 ===
	reg [11:0] digit_bitmap [9:0][11:0];

	initial begin
	  // 0
	  digit_bitmap[0][ 0] = 12'b001111111100;
	  digit_bitmap[0][ 1] = 12'b011000000110;
	  digit_bitmap[0][ 2] = 12'b110000000011;
	  digit_bitmap[0][ 3] = 12'b110000000011;
	  digit_bitmap[0][ 4] = 12'b110000000011;
	  digit_bitmap[0][ 5] = 12'b110000000011;
	  digit_bitmap[0][ 6] = 12'b110000000011;
	  digit_bitmap[0][ 7] = 12'b110000000011;
	  digit_bitmap[0][ 8] = 12'b110000000011;
	  digit_bitmap[0][ 9] = 12'b110000000011;
	  digit_bitmap[0][10] = 12'b011000000110;
	  digit_bitmap[0][11] = 12'b001111111100;

	  // 1
	  digit_bitmap[1][ 0] = 12'b000001110000;
	  digit_bitmap[1][ 1] = 12'b000011110000;
	  digit_bitmap[1][ 2] = 12'b000001110000;
	  digit_bitmap[1][ 3] = 12'b000001110000;
	  digit_bitmap[1][ 4] = 12'b000001110000;
	  digit_bitmap[1][ 5] = 12'b000001110000;
	  digit_bitmap[1][ 6] = 12'b000001110000;
	  digit_bitmap[1][ 7] = 12'b000001110000;
	  digit_bitmap[1][ 8] = 12'b000001110000;
	  digit_bitmap[1][ 9] = 12'b000001110000;
	  digit_bitmap[1][10] = 12'b000001110000;
	  digit_bitmap[1][11] = 12'b001111111100;

	  // 2
	  digit_bitmap[2][ 0] = 12'b001111111100;
	  digit_bitmap[2][ 1] = 12'b011000000110;
	  digit_bitmap[2][ 2] = 12'b000000000110;
	  digit_bitmap[2][ 3] = 12'b000000001100;
	  digit_bitmap[2][ 4] = 12'b000000011000;
	  digit_bitmap[2][ 5] = 12'b000000110000;
	  digit_bitmap[2][ 6] = 12'b000001100000;
	  digit_bitmap[2][ 7] = 12'b000011000000;
	  digit_bitmap[2][ 8] = 12'b000110000000;
	  digit_bitmap[2][ 9] = 12'b001100000000;
	  digit_bitmap[2][10] = 12'b011000000000;
	  digit_bitmap[2][11] = 12'b111111111111;

	  // 3
	  digit_bitmap[3][ 0] = 12'b001111111100;
	  digit_bitmap[3][ 1] = 12'b011000000110;
	  digit_bitmap[3][ 2] = 12'b000000000110;
	  digit_bitmap[3][ 3] = 12'b000000001100;
	  digit_bitmap[3][ 4] = 12'b000111111100;
	  digit_bitmap[3][ 5] = 12'b000000000110;
	  digit_bitmap[3][ 6] = 12'b000000000110;
	  digit_bitmap[3][ 7] = 12'b000000000110;
	  digit_bitmap[3][ 8] = 12'b011000000110;
	  digit_bitmap[3][ 9] = 12'b011000000110;
	  digit_bitmap[3][10] = 12'b011000000110;
	  digit_bitmap[3][11] = 12'b001111111100;

	  // 4
	  digit_bitmap[4][ 0] = 12'b000000111100;
	  digit_bitmap[4][ 1] = 12'b000001111100;
	  digit_bitmap[4][ 2] = 12'b000011011100;
	  digit_bitmap[4][ 3] = 12'b000110011100;
	  digit_bitmap[4][ 4] = 12'b001100011100;
	  digit_bitmap[4][ 5] = 12'b011000011100;
	  digit_bitmap[4][ 6] = 12'b111111111111;
	  digit_bitmap[4][ 7] = 12'b000000011100;
	  digit_bitmap[4][ 8] = 12'b000000011100;
	  digit_bitmap[4][ 9] = 12'b000000011100;
	  digit_bitmap[4][10] = 12'b000000011100;
	  digit_bitmap[4][11] = 12'b000000011100;

	  // 5
	  digit_bitmap[5][ 0] = 12'b111111111111;
	  digit_bitmap[5][ 1] = 12'b110000000000;
	  digit_bitmap[5][ 2] = 12'b110000000000;
	  digit_bitmap[5][ 3] = 12'b111111111100;
	  digit_bitmap[5][ 4] = 12'b000000000110;
	  digit_bitmap[5][ 5] = 12'b000000000110;
	  digit_bitmap[5][ 6] = 12'b000000000110;
	  digit_bitmap[5][ 7] = 12'b000000000110;
	  digit_bitmap[5][ 8] = 12'b110000000110;
	  digit_bitmap[5][ 9] = 12'b110000000110;
	  digit_bitmap[5][10] = 12'b011000001100;
	  digit_bitmap[5][11] = 12'b001111111000;

	  // 6
	  digit_bitmap[6][ 0] = 12'b001111111100;
	  digit_bitmap[6][ 1] = 12'b011000000000;
	  digit_bitmap[6][ 2] = 12'b110000000000;
	  digit_bitmap[6][ 3] = 12'b111111111100;
	  digit_bitmap[6][ 4] = 12'b110000000110;
	  digit_bitmap[6][ 5] = 12'b110000000110;
	  digit_bitmap[6][ 6] = 12'b110000000110;
	  digit_bitmap[6][ 7] = 12'b110000000110;
	  digit_bitmap[6][ 8] = 12'b110000000110;
	  digit_bitmap[6][ 9] = 12'b011000001100;
	  digit_bitmap[6][10] = 12'b001100011000;
	  digit_bitmap[6][11] = 12'b000111110000;

	  // 7
	  digit_bitmap[7][ 0] = 12'b111111111111;
	  digit_bitmap[7][ 1] = 12'b000000000110;
	  digit_bitmap[7][ 2] = 12'b000000001100;
	  digit_bitmap[7][ 3] = 12'b000000011000;
	  digit_bitmap[7][ 4] = 12'b000000110000;
	  digit_bitmap[7][ 5] = 12'b000001100000;
	  digit_bitmap[7][ 6] = 12'b000011000000;
	  digit_bitmap[7][ 7] = 12'b000110000000;
	  digit_bitmap[7][ 8] = 12'b001100000000;
	  digit_bitmap[7][ 9] = 12'b001100000000;
	  digit_bitmap[7][10] = 12'b001100000000;
	  digit_bitmap[7][11] = 12'b001100000000;

	  // 8
	  digit_bitmap[8][ 0] = 12'b001111111100;
	  digit_bitmap[8][ 1] = 12'b011000000110;
	  digit_bitmap[8][ 2] = 12'b011000000110;
	  digit_bitmap[8][ 3] = 12'b011000000110;
	  digit_bitmap[8][ 4] = 12'b001111111100;
	  digit_bitmap[8][ 5] = 12'b011000000110;
	  digit_bitmap[8][ 6] = 12'b011000000110;
	  digit_bitmap[8][ 7] = 12'b011000000110;
	  digit_bitmap[8][ 8] = 12'b011000000110;
	  digit_bitmap[8][ 9] = 12'b011000000110;
	  digit_bitmap[8][10] = 12'b011000000110;
	  digit_bitmap[8][11] = 12'b001111111100;

	  // 9
	  digit_bitmap[9][ 0] = 12'b001111111100;
	  digit_bitmap[9][ 1] = 12'b011000000110;
	  digit_bitmap[9][ 2] = 12'b110000000110;
	  digit_bitmap[9][ 3] = 12'b110000000110;
	  digit_bitmap[9][ 4] = 12'b110000000110;
	  digit_bitmap[9][ 5] = 12'b011111111110;
	  digit_bitmap[9][ 6] = 12'b000000000110;
	  digit_bitmap[9][ 7] = 12'b000000000110;
	  digit_bitmap[9][ 8] = 12'b000000000110;
	  digit_bitmap[9][ 9] = 12'b000000001100;
	  digit_bitmap[9][10] = 12'b000000011000;
	  digit_bitmap[9][11] = 12'b001111110000;
	end


	
	// === 計分邏輯 ===
	reg [16:0] score;
	reg [6:0] counter;
	
	always @(posedge clk_100 or negedge rst_n) begin
		if(!rst_n) begin
			score <= 17'd0;
			counter <= 7'd0;
		end
		else begin
			if(is_living) begin
				if(counter < 7'd100)
					counter <= counter + 1'b1;
					
				else begin
					counter <= 7'd0;
					score <= score + 7'd10;
				end
			end
		end
	end
	
	// === 拆分數字 ===
	reg [3:0] digit[5:0];  // 6 位數字，每位 0~9
	integer i;
	integer temp_score;
	
	always @(*) begin
		temp_score = score;
		for (i = 0; i < 6; i = i + 1) begin
			digit[i] = temp_score % 10;  // 取當前最低位
			temp_score = temp_score / 10; // 去掉最低位
		end
	end
	
	
	
	// === 繪圖邏輯 ===
	reg digit_draw [5:0];
	parameter X_base = 11'd700;
	parameter Y_base = 11'd150;
	parameter digit_width = 4'd12;
	parameter digit_height = 4'd12;
	
	
	// 分別計算每一個位置的輸出
	integer idx;
	always @(*) begin
		for(idx = 0; idx < 6; idx = idx + 1) begin
			if((pixel_xpos >= (X_base - idx * digit_width)) &&  
			(pixel_xpos < (X_base - idx * digit_width + digit_width)) &&
			(pixel_ypos >= Y_base) && (pixel_ypos < Y_base + digit_height)) begin
				
				digit_draw[idx] = digit_bitmap[digit[idx]][pixel_ypos - Y_base][digit_width-1 - (pixel_xpos - (X_base - idx*digit_width))];
			end
			else 
				digit_draw[idx] = 1'b0;
		end
	end
	
	assign score_draw = digit_draw[0] | digit_draw[1] | digit_draw[2]| digit_draw[3]| digit_draw[4]| digit_draw[5];
endmodule