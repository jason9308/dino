module cactus(
    input	lcd_pclk,
	input	clk_100,
    input	rst_n,
    input	[10:0]  pixel_xpos,
    input	[10:0]  pixel_ypos,
	input	[4:0] random_five,
	input	[2:0] random_three,
	input	is_living,
	input	[3:0] move_rate,
	
    output reg cactus_draw,
	output reg cactus_draw_2
);

	// === 定義仙人掌形狀的Bitmap 分別有大中小三種 ===
	reg [39:0] cactus0 [57:0];
    reg [29:0] cactus1 [57:0];
    reg [19:0] cactus2 [57:0];
	
	initial begin
		cactus0[0] <= 40'b0000000000_0000000111_1110000000_0000000000;
        cactus0[1] <= 40'b0000000000_0000001111_1111000000_0000000000;
        cactus0[2] <= 40'b0000000000_0000011111_1111100000_0000000000;
        cactus0[3] <= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[4] <= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[5] <= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[6] <= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[7] <= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[8] <= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[9] <= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[10]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[11]<= 40'b0000011000_0000111111_1111110000_0000000000;
        cactus0[12]<= 40'b0000111100_0000111111_1111110000_0000000000;
        cactus0[13]<= 40'b0001111110_0000111111_1111110000_0000000000;
        cactus0[14]<= 40'b0011111111_0000111111_1111110000_0011000000;
        cactus0[15]<= 40'b0011111111_0000111111_1111110000_0111100000;
        cactus0[16]<= 40'b0011111111_0000111111_1111110000_1111110000;
        cactus0[17]<= 40'b0011111111_0000111111_1111110000_1111110000;
        cactus0[18]<= 40'b0011111111_0000111111_1111110000_1111110000;
        cactus0[19]<= 40'b0011111111_1111111111_1111110000_1111110000;
        cactus0[20]<= 40'b0011111111_1111111111_1111110000_1111110000;
        cactus0[21]<= 40'b0011111111_1111111111_1111110000_1111110000;
        cactus0[22]<= 40'b0011111111_1111111111_1111110000_1111110000;
        cactus0[23]<= 40'b0011111111_1111111111_1111111111_1111110000;
        cactus0[24]<= 40'b0000111111_1111111111_1111111111_1111110000;
        cactus0[25]<= 40'b0000001111_1111111111_1111111111_1111110000;
        cactus0[26]<= 40'b0000000011_1111111111_1111111111_1111000000;
        cactus0[27]<= 40'b0000000000_1111111111_1111111111_1100000000;
        cactus0[28]<= 40'b0000000000_0000111111_1111111111_0000000000;
        cactus0[29]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[30]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[31]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[32]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[33]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[34]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[35]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[36]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[37]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[38]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[39]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[40]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[41]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[42]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[43]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[44]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[45]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[46]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[47]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[48]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[49]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[50]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[51]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[52]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[53]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[54]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[55]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[56]<= 40'b0000000000_0000111111_1111110000_0000000000;
        cactus0[57]<= 40'b0000000000_0000111111_1111110000_0000000000;

        cactus1[0] <= 30'b0000000000_0000000000_0000000000;
        cactus1[1] <= 30'b0000000000_0000000000_0000000000;
        cactus1[2] <= 30'b0000000000_0000000000_0000000000;
        cactus1[3] <= 30'b0000000000_0000000000_0000000000;
        cactus1[4] <= 30'b0000000000_0000000000_0000000000;
        cactus1[5] <= 30'b0000000000_0000000000_0000000000;
        cactus1[6] <= 30'b0000000000_0000000000_0000000000;
        cactus1[7] <= 30'b0000000000_0000000000_0000000000;
        cactus1[8] <= 30'b0000000000_0000000000_0000000000;
        cactus1[9] <= 30'b0000000000_0000000000_0000000000;
        cactus1[10]<= 30'b0000000000_0000000000_0000000000;
        cactus1[11]<= 30'b0000000000_0000000000_0000000000;
        cactus1[12]<= 30'b0000000000_0000000000_0000000000;
        cactus1[13]<= 30'b0000000000_0000000000_0000000000;
        cactus1[14]<= 30'b0000000000_0000000000_0000000000;
        cactus1[15]<= 30'b0000000000_0000000000_0000000000;
        cactus1[16]<= 30'b0000000000_0000000000_0000000000;
        cactus1[17]<= 30'b0000000000_0000000000_0000000000;
        cactus1[18]<= 30'b0000000000_0000000000_0000000000;
        cactus1[19]<= 30'b0000000000_0000000000_0000000000;
        cactus1[20]<= 30'b0000000000_0000000000_0000000000;
        cactus1[21]<= 30'b0000000000_0000000000_0000000000;
        cactus1[22]<= 30'b0000000000_0011110000_0000000000;
        cactus1[23]<= 30'b0000000000_1111111000_0000000000;
        cactus1[24]<= 30'b0000000000_1111111000_0000000000;
        cactus1[25]<= 30'b0000000000_1111111000_0000111100;
        cactus1[26]<= 30'b0000000000_1111111000_0001111110;
        cactus1[27]<= 30'b0000000000_1111111000_0001111110;
        cactus1[28]<= 30'b0000000000_1111111000_0001111110;
        cactus1[29]<= 30'b0000000000_1111111000_0001111110;
        cactus1[30]<= 30'b0000000000_1111111000_0001111110;
        cactus1[31]<= 30'b0000000000_1111111100_0001111110;
        cactus1[32]<= 30'b0000000000_1111111100_0001111100;
        cactus1[33]<= 30'b0000000000_1111111111_1111111100;
        cactus1[34]<= 30'b0000000000_1111111111_1111111000;
        cactus1[35]<= 30'b0000000000_1111111111_1111100000;
        cactus1[36]<= 30'b0000000000_1111111111_0000000000;
        cactus1[37]<= 30'b0000000000_1111111000_0000000000;
        cactus1[38]<= 30'b0000000000_1111111000_0000000000;
        cactus1[39]<= 30'b0000000000_1111111000_0000000000;
        cactus1[40]<= 30'b0111100000_1111111000_0000000000;
        cactus1[41]<= 30'b0111110000_1111111000_0000111100;
        cactus1[42]<= 30'b0111110000_1111111000_0001111110;
        cactus1[43]<= 30'b0111110000_1111111000_0001111110;
        cactus1[44]<= 30'b0111110000_1111111000_0001111110;
        cactus1[45]<= 30'b0111111000_1111111000_0001111110;
        cactus1[46]<= 30'b0111111100_1111111000_0001111110;
        cactus1[47]<= 30'b0111111111_1111111100_0001111110;
        cactus1[48]<= 30'b0011111111_1111111100_0001111100;
        cactus1[49]<= 30'b0000111111_1111111111_1111111100;
        cactus1[50]<= 30'b0000000000_1111111111_1111111000;
        cactus1[51]<= 30'b0000000000_1111111111_1111100000;
        cactus1[52]<= 30'b0000000000_1111111111_0000000000;
        cactus1[53]<= 30'b0000000000_1111111000_0000000000;
        cactus1[54]<= 30'b0000000000_1111111000_0000000000;
        cactus1[55]<= 30'b0000000000_1111111000_0000000000;
        cactus1[56]<= 30'b0000000000_1111111000_0000000000;
        cactus1[57]<= 30'b0000000000_1111111000_0000000000;
        
        cactus2[0] <= 20'b0000000000_0000000000;
        cactus2[1] <= 20'b0000000000_0000000000;
        cactus2[2] <= 20'b0000000000_0000000000;
        cactus2[3] <= 20'b0000000000_0000000000;
        cactus2[4] <= 20'b0000000000_0000000000;
        cactus2[5] <= 20'b0000000000_0000000000;
        cactus2[6] <= 20'b0000000000_0000000000;
        cactus2[7] <= 20'b0000000000_0000000000;
        cactus2[8] <= 20'b0000000000_0000000000;
        cactus2[9] <= 20'b0000000000_0000000000;
        cactus2[10]<= 20'b0000000000_0000000000;
        cactus2[11]<= 20'b0000000000_0000000000;
        cactus2[12]<= 20'b0000000000_0000000000;
        cactus2[13]<= 20'b0000000000_0000000000;
        cactus2[14]<= 20'b0000000000_0000000000;
        cactus2[15]<= 20'b0000000000_0000000000;
        cactus2[16]<= 20'b0000000000_0000000000;
        cactus2[17]<= 20'b0000000000_0000000000;
        cactus2[18]<= 20'b0000000000_0000000000;
        cactus2[19]<= 20'b0000000000_0000000000;
        cactus2[20]<= 20'b0000000000_0000000000;
        cactus2[21]<= 20'b0000000000_0000000000;
        cactus2[22]<= 20'b0000000000_0000000000;
        cactus2[23]<= 20'b0000000000_0000000000;
        cactus2[24]<= 20'b0000000000_0000000000;
        cactus2[25]<= 20'b0000000000_0000000000;
        cactus2[26]<= 20'b0000000000_0000000000;
        cactus2[27]<= 20'b0000000000_0000000000;
        cactus2[28]<= 20'b0000000000_0000000000;
        cactus2[29]<= 20'b0000000000_0000000000;
        cactus2[30]<= 20'b0000000000_0000000000;
        cactus2[31]<= 20'b0000000001_1000000000;
        cactus2[32]<= 20'b0000000011_1100000000;
        cactus2[33]<= 20'b0000000111_1110000000;
        cactus2[34]<= 20'b0000000111_1110000000;
        cactus2[35]<= 20'b0000000111_1110000000;
        cactus2[36]<= 20'b0000000111_1110000000;
        cactus2[37]<= 20'b0000000111_1110000000;
        cactus2[38]<= 20'b0000000111_1110000000;
        cactus2[39]<= 20'b0000000111_1110000000;
        cactus2[40]<= 20'b0001000111_1110000000;
        cactus2[41]<= 20'b0011100111_1110000000;
        cactus2[42]<= 20'b0011100111_1110000000;
        cactus2[43]<= 20'b0011100111_1110000000;
        cactus2[44]<= 20'b0011100111_1110001000;
        cactus2[45]<= 20'b0011100111_1110011100;
        cactus2[46]<= 20'b0011111111_1110011100;
        cactus2[47]<= 20'b0001111111_1110011100;
        cactus2[48]<= 20'b0000111111_1111111100;
        cactus2[49]<= 20'b0000011111_1111111000;
        cactus2[50]<= 20'b0000001111_1111110000;
        cactus2[51]<= 20'b0000000111_1111100000;
        cactus2[52]<= 20'b0000000111_1111000000;
        cactus2[53]<= 20'b0000000111_1110000000;
        cactus2[54]<= 20'b0000000111_1110000000;
        cactus2[55]<= 20'b0000000111_1110000000;
        cactus2[56]<= 20'b0000000111_1110000000;
        cactus2[57]<= 20'b0000000111_1110000000;
	end
	
	// === 定義仙人掌寬度與高度 ===
    parameter CACTUS_H   = 58;
    parameter CACTUS0_W  = 40;
    parameter CACTUS1_W  = 30;
    parameter CACTUS2_W  = 20;
    parameter CACTUS_Y   = 437;
	
	// === === ===  這部分是第一組(主要)仙人掌=== === ===
    reg [10:0] offset; // 整組 cactus 起始位置
    reg [1:0] cactus_type [2:0]; // 每棵 cactus 的大小類型
    reg [1:0] cactus_count;      // 一組 cactus 的棵數
    reg [8:0] wait_counter;
    reg [8:0] wait_interval;
    reg [6:0] cactus_width;      // 一整組 cactus 的寬度
	reg [6:0] second_cactus_offset;
	reg [6:0] third_cactus_offset;
	

    integer i;
	reg [1:0] type_temp_idx;

    // === cactus 出現與移動邏輯 ===
    always @(posedge clk_100 or negedge rst_n) begin
        if(!rst_n) begin
            offset <= 11'd0;
            cactus_count <= 2'd0;
            wait_counter <= 9'd0;
            wait_interval <= 9'd0;
            cactus_width <= 7'd0;
			second_cactus_offset <= 7'd0;
			third_cactus_offset <= 7'd0;
			type_temp_idx <= 2'd0;
			cactus_type[0] <= 2'd0;
			cactus_type[1] <= 2'd0;
			cactus_type[2] <= 2'd0;
        end 
		else if(is_living) begin
            if(offset == 11'd0) begin
                if(wait_counter == 9'd0) begin
                    wait_interval <= random_five * 4'd5; // 隨機等待時間
                    cactus_count <= (random_five % 3) + 1;
                    cactus_type[0] <= random_five % 3;
                    cactus_type[1] <= random_three % 3;
                    cactus_type[2] <= (random_five + random_three) % 3;
					cactus_width <= 7'd0;
					second_cactus_offset <= 7'd0;
					third_cactus_offset <= 7'd0;
                    wait_counter <= 9'd1;
					type_temp_idx <= 2'd0;
                end 
				else begin
                    wait_counter <= wait_counter + 1;
					if(wait_counter >= 9'd1 && wait_counter <= cactus_count) begin
						// 如果cactus_count有到2的話 要記錄相較基準點的offset給第二棵仙人掌
						if(wait_counter == 2) begin
							if(cactus_type[0] == 2'd0)
								second_cactus_offset <= CACTUS0_W;
							else if(cactus_type[0] == 2'd1)
								second_cactus_offset <= CACTUS1_W;
							else if(cactus_type[0] == 2'd2)
								second_cactus_offset <= CACTUS2_W;
						end
						// 如果cactus_count有到3的話 要記錄相較基準點的offset給第三棵仙人掌
						else if(wait_counter == 3) begin
							if(cactus_type[1] == 2'd0)
								third_cactus_offset <= second_cactus_offset + CACTUS0_W;
							else if(cactus_type[1] == 2'd1)
								third_cactus_offset <= second_cactus_offset + CACTUS1_W;
							else if(cactus_type[1] == 2'd2)
								third_cactus_offset <= second_cactus_offset + CACTUS2_W;
						end
						
						// 這部分是計算整組仙人掌寬度 但是一個cycle只檢查一個 才有辦法累加
						type_temp_idx <= wait_counter;
						case(cactus_type[type_temp_idx])
                            0: cactus_width <= cactus_width + CACTUS0_W;
                            1: cactus_width <= cactus_width + CACTUS1_W;
                            2: cactus_width <= cactus_width + CACTUS2_W;
                        endcase
					end
                    else if(wait_counter >= wait_interval) begin
                        offset <= move_rate; // 從右側出現
                        wait_counter <= 9'd0;
                    end
                end
            end 
			else if(offset >= (11'd800 + cactus_width))
				offset <= 11'd0;
			else begin
                offset <= (offset + move_rate) % (11'd800 + cactus_width);
            end
        end
    end

    // === 繪圖邏輯 ===
    always @(*) begin
		if(pixel_ypos <= CACTUS_Y && pixel_ypos > CACTUS_Y - CACTUS_H) begin
			cactus_draw = 0;
			case(cactus_count)
				1: begin
					if((pixel_xpos >= ((offset < 11'd800) ? 11'd800 - offset : 11'd0)) && pixel_xpos < (11'd800 + cactus_width - offset)) begin
						case(cactus_type[0])
							0: begin 
								if(cactus0[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset)])
									cactus_draw = 1;
							end
							1: begin 
								if(cactus1[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset)])
									cactus_draw = 1;
							end
							2: begin 
								if(cactus2[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset)])
									cactus_draw = 1;
							end
						endcase
					end					
				end
				
				2: begin
					if(offset < 11'd800 + second_cactus_offset) begin
						if((pixel_xpos >= ((offset < 11'd800) ? 11'd800 - offset : 11'd0)) && pixel_xpos < (11'd800 + second_cactus_offset - offset)) begin
							case(cactus_type[0])
								0: begin 
									if(cactus0[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset)])
										cactus_draw = 1;
								end
								1: begin 
									if(cactus1[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset)])
										cactus_draw = 1;
								end
								2: begin 
									if(cactus2[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset)])
										cactus_draw = 1;
								end
							endcase
						end
					end
					
					if(offset < 11'd800 + cactus_width) begin
						if((pixel_xpos >= ((offset < (11'd800 + second_cactus_offset)) ? (11'd800 + second_cactus_offset - offset) : 11'd0)) && pixel_xpos < (11'd800 + cactus_width - offset)) begin
							case(cactus_type[1])
								0: begin 
									if(cactus0[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset + second_cactus_offset)])
										cactus_draw = 1;
								end
								1: begin 
									if(cactus1[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset + second_cactus_offset)])
										cactus_draw = 1;
								end
								2: begin 
									if(cactus2[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset + second_cactus_offset)])
										cactus_draw = 1;
								end
							endcase
						end
					end
				end
				
				3: begin
					if(offset < 11'd800 + second_cactus_offset) begin
						if((pixel_xpos >= ((offset < 11'd800) ? 11'd800 - offset : 11'd0)) && pixel_xpos < (11'd800 + second_cactus_offset - offset)) begin
							case(cactus_type[0])
								0: begin 
									if(cactus0[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset)])
										cactus_draw = 1;
								end
								1: begin 
									if(cactus1[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset)])
										cactus_draw = 1;
								end
								2: begin 
									if(cactus2[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset)])
										cactus_draw = 1;
								end
							endcase
						end
					end
					if(offset < 11'd800 + third_cactus_offset) begin
						if((pixel_xpos >= ((offset < (11'd800 + second_cactus_offset)) ? (11'd800 + second_cactus_offset - offset) : 11'd0)) && pixel_xpos < (11'd800 + third_cactus_offset - offset)) begin
							case(cactus_type[1])
								0: begin 
									if(cactus0[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset + second_cactus_offset)])
										cactus_draw = 1;
								end
								1: begin 
									if(cactus1[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset + second_cactus_offset)])
										cactus_draw = 1;
								end
								2: begin 
									if(cactus2[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset + second_cactus_offset)])
										cactus_draw = 1;
								end
							endcase
						end
					end
					if(offset < 11'd800 + cactus_width) begin
						if((pixel_xpos >= ((offset < (11'd800 + third_cactus_offset)) ? (11'd800 + third_cactus_offset - offset) : 11'd0)) && pixel_xpos < (11'd800 + cactus_width - offset)) begin
							case(cactus_type[2])
								0: begin 
									if(cactus0[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset + third_cactus_offset)])
										cactus_draw = 1;
								end
								1: begin 
									if(cactus1[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset + third_cactus_offset)])
										cactus_draw = 1;
								end
								2: begin 
									if(cactus2[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset + third_cactus_offset)])
										cactus_draw = 1;
								end
							endcase
						end
					end
				end
			endcase
		end
		else begin
			cactus_draw = 0;
		end
	end
	
	// === === ===  以下是第二組仙人掌(可能刷新)=== === ===
	reg [10:0] offset_2; // 整組 cactus 起始位置
    reg [1:0] cactus_type_2 [2:0]; // 每棵 cactus 的大小類型
    reg [1:0] cactus_count_2;      // 一組 cactus 的棵數
    reg [8:0] wait_counter_2;
    reg [8:0] wait_interval_2;
    reg [6:0] cactus_width_2;      // 一整組 cactus 的寬度
	reg [6:0] second_cactus_offset_2;
	reg [6:0] third_cactus_offset_2;
	
	reg [1:0] type_temp_idx_2;
	
	// === cactus2 出現與移動邏輯 ===
	//				(主要就是第一組仙人掌到某個位置的時候 隨機決定要不要刷新出來)
    always @(posedge clk_100 or negedge rst_n) begin
        if(!rst_n) begin
            offset_2 <= 11'd0;
            cactus_count_2 <= 2'd0;
            wait_counter_2 <= 9'd0;
            wait_interval_2 <= 9'd0;
            cactus_width_2 <= 7'd0;
			second_cactus_offset_2 <= 7'd0;
			third_cactus_offset_2 <= 7'd0;
			type_temp_idx_2 <= 2'd0;
			cactus_type_2[0] <= 2'd0;
			cactus_type_2[1] <= 2'd0;
			cactus_type_2[2] <= 2'd0;
        end 
		else if(is_living) begin
			if(offset_2 == 11'd0) begin
				if(wait_counter_2 == 9'd0) begin
					if(offset >= 11'd380 && offset <= 11'd400 && (random_five % 2) == 1'b1) begin 
					// 第一組仙人掌到某個區間的時候 隨機決定要不要刷新第二組
						wait_interval_2 <= 9'd30 + random_five * 4'd2; // 隨機等待時間
						cactus_count_2 <= (random_five % 3) + 1;
						cactus_type_2[0] <= random_five % 3;
						cactus_type_2[1] <= random_three % 3;
						cactus_type_2[2] <= (random_five + random_three) % 3;
						cactus_width_2 <= 7'd0;
						second_cactus_offset_2 <= 7'd0;
						third_cactus_offset_2 <= 7'd0;
						wait_counter_2 <= 9'd1;
						type_temp_idx_2 <= 2'd0;
					end	
				end 
				else begin
					wait_counter_2 <= wait_counter_2 + 1;
					if(wait_counter_2 >= 9'd1 && wait_counter_2 <= cactus_count_2) begin
						// 如果cactus_count_2有到2的話 要記錄相較基準點的offset_2給第二棵仙人掌
						if(wait_counter_2 == 2) begin
							if(cactus_type_2[0] == 2'd0)
								second_cactus_offset_2 <= CACTUS0_W;
							else if(cactus_type_2[0] == 2'd1)
								second_cactus_offset_2 <= CACTUS1_W;
							else if(cactus_type_2[0] == 2'd2)
								second_cactus_offset_2 <= CACTUS2_W;
						end
						// 如果cactus_count_2有到3的話 要記錄相較基準點的offset_2給第三棵仙人掌
						else if(wait_counter_2 == 3) begin
							if(cactus_type_2[1] == 2'd0)
								third_cactus_offset_2 <= second_cactus_offset_2 + CACTUS0_W;
							else if(cactus_type_2[1] == 2'd1)
								third_cactus_offset_2 <= second_cactus_offset_2 + CACTUS1_W;
							else if(cactus_type_2[1] == 2'd2)
								third_cactus_offset_2 <= second_cactus_offset_2 + CACTUS2_W;
						end
						
						// 這部分是計算整組仙人掌寬度 但是一個cycle只檢查一個 才有辦法累加
						type_temp_idx_2 <= wait_counter_2;
						case(cactus_type_2[type_temp_idx_2])
							0: cactus_width_2 <= cactus_width_2 + CACTUS0_W;
							1: cactus_width_2 <= cactus_width_2 + CACTUS1_W;
							2: cactus_width_2 <= cactus_width_2 + CACTUS2_W;
						endcase
					end
					else if(wait_counter_2 >= wait_interval_2) begin
						offset_2 <= move_rate; // 從右側出現
						wait_counter_2 <= 9'd0;
					end
				end
			end 
			else if(offset_2 >= (11'd800 + cactus_width_2))
				offset_2 <= 11'd0;
			else begin
				offset_2 <= (offset_2 + move_rate) % (11'd800 + cactus_width_2);
			end
    
        end // is_living
    end
	
	// === 繪圖邏輯 ===
    always @(*) begin
		if(pixel_ypos <= CACTUS_Y && pixel_ypos > CACTUS_Y - CACTUS_H) begin
			cactus_draw_2 = 0;
			case(cactus_count_2)
				1: begin
					if((pixel_xpos >= ((offset_2 < 11'd800) ? 11'd800 - offset_2 : 11'd0)) && pixel_xpos < (11'd800 + cactus_width_2 - offset_2)) begin
						case(cactus_type_2[0])
							0: begin 
								if(cactus0[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset_2)])
									cactus_draw_2 = 1;
							end
							1: begin 
								if(cactus1[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset_2)])
									cactus_draw_2 = 1;
							end
							2: begin 
								if(cactus2[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset_2)])
									cactus_draw_2 = 1;
							end
						endcase
					end					
				end
				
				2: begin
					if(offset_2 < 11'd800 + second_cactus_offset_2) begin
						if((pixel_xpos >= ((offset_2 < 11'd800) ? 11'd800 - offset_2 : 11'd0)) && pixel_xpos < (11'd800 + second_cactus_offset_2 - offset_2)) begin
							case(cactus_type_2[0])
								0: begin 
									if(cactus0[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset_2)])
										cactus_draw_2 = 1;
								end
								1: begin 
									if(cactus1[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset_2)])
										cactus_draw_2 = 1;
								end
								2: begin 
									if(cactus2[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset_2)])
										cactus_draw_2 = 1;
								end
							endcase
						end
					end
					
					if(offset_2 < 11'd800 + cactus_width_2) begin
						if((pixel_xpos >= ((offset_2 < (11'd800 + second_cactus_offset_2)) ? (11'd800 + second_cactus_offset_2 - offset_2) : 11'd0)) && pixel_xpos < (11'd800 + cactus_width_2 - offset_2)) begin
							case(cactus_type_2[1])
								0: begin 
									if(cactus0[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset_2 + second_cactus_offset_2)])
										cactus_draw_2 = 1;
								end
								1: begin 
									if(cactus1[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset_2 + second_cactus_offset_2)])
										cactus_draw_2 = 1;
								end
								2: begin 
									if(cactus2[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset_2 + second_cactus_offset_2)])
										cactus_draw_2 = 1;
								end
							endcase
						end
					end
				end
				
				3: begin
					if(offset_2 < 11'd800 + second_cactus_offset_2) begin
						if((pixel_xpos >= ((offset_2 < 11'd800) ? 11'd800 - offset_2 : 11'd0)) && pixel_xpos < (11'd800 + second_cactus_offset_2 - offset_2)) begin
							case(cactus_type_2[0])
								0: begin 
									if(cactus0[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset_2)])
										cactus_draw_2 = 1;
								end
								1: begin 
									if(cactus1[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset_2)])
										cactus_draw_2 = 1;
								end
								2: begin 
									if(cactus2[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset_2)])
										cactus_draw_2 = 1;
								end
							endcase
						end
					end
					if(offset_2 < 11'd800 + third_cactus_offset_2) begin
						if((pixel_xpos >= ((offset_2 < (11'd800 + second_cactus_offset_2)) ? (11'd800 + second_cactus_offset_2 - offset_2) : 11'd0)) && pixel_xpos < (11'd800 + third_cactus_offset_2 - offset_2)) begin
							case(cactus_type_2[1])
								0: begin 
									if(cactus0[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset_2 + second_cactus_offset_2)])
										cactus_draw_2 = 1;
								end
								1: begin 
									if(cactus1[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset_2 + second_cactus_offset_2)])
										cactus_draw_2 = 1;
								end
								2: begin 
									if(cactus2[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset_2 + second_cactus_offset_2)])
										cactus_draw_2 = 1;
								end
							endcase
						end
					end
					if(offset_2 < 11'd800 + cactus_width_2) begin
						if((pixel_xpos >= ((offset_2 < (11'd800 + third_cactus_offset_2)) ? (11'd800 + third_cactus_offset_2 - offset_2) : 11'd0)) && pixel_xpos < (11'd800 + cactus_width_2 - offset_2)) begin
							case(cactus_type_2[2])
								0: begin 
									if(cactus0[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset_2 + third_cactus_offset_2)])
										cactus_draw_2 = 1;
								end
								1: begin 
									if(cactus1[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset_2 + third_cactus_offset_2)])
										cactus_draw_2 = 1;
								end
								2: begin 
									if(cactus2[pixel_ypos - (CACTUS_Y - CACTUS_H)][pixel_xpos - (800 - offset_2 + third_cactus_offset_2)])
										cactus_draw_2 = 1;
								end
							endcase
						end
					end
				end
			endcase
		end
		else begin
			cactus_draw_2 = 0;
		end
	end
	
endmodule