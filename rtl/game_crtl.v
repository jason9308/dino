module game_crtl(
    input	lcd_pclk,
	input	clk_100,
    input	rst_n,
	input 	dino_draw,
	input	cactus_draw,
	input	cactus_draw_2,
	input	key_flag,
	input	key_value,
	
    output  reg [3:0] move_rate,
	output	is_living,
	output	is_dying
);

	parameter IDLE = 2'd0;
	parameter PLAY = 2'd1;
	parameter OVER = 2'd2;
	reg [1:0] game_status;
	
	// === 遊戲狀態 ===
	always @(posedge lcd_pclk or negedge rst_n) begin
		if(!rst_n) begin
			game_status <= IDLE;
		end
		else begin
			case(game_status)
				IDLE: begin
					if(key_flag && (~key_value))
						game_status <= PLAY;
				end
				PLAY: begin
					if((dino_draw && cactus_draw) || (dino_draw && cactus_draw_2))
						game_status <= OVER;
				end
				OVER: begin
				end
				default: begin
				end
			endcase
		end
	end
	
	// === 移動速度控制 ===
	reg [13:0] rate_counter;
	
	always @(posedge clk_100 or negedge rst_n) begin
		if(!rst_n) begin
			move_rate <= 4'd4;
			rate_counter <= 14'd0;
		end
		else begin
			if(game_status == PLAY && move_rate < 4'd10) begin
				if(rate_counter < 14'd10000)
					rate_counter <= rate_counter + 1'b1;
				else begin
					rate_counter <= 14'd0;
					move_rate <= move_rate + 1'b1;
				end
			end
		end
	end
	
	// === 輸出 ===
	assign is_living = (game_status == PLAY);
	assign is_dying = (game_status == OVER);

endmodule