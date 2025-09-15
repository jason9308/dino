module lcd_display(
    input	lcd_pclk,
    input	rst_n,
    input	[10:0]  pixel_xpos,
    input	[10:0]  pixel_ypos,  
    input	[10:0]  h_disp,
    input	[10:0]  v_disp, 
	input 	dino_draw,
	input 	ground_draw,
	input	cactus_draw,
	input	cactus_draw_2,
	input	score_draw,
	//input	cactus_2_draw,
	input 	cloud_draw,
    output  reg  [23:0]  pixel_data
);

	// parameter define  
	parameter WHITE = 24'hFFFFFF; 
	parameter BLACK = 24'h000000; 
	parameter RED   = 24'hFF0000; 
	parameter GREEN = 24'h00FF00; 
	parameter BLUE  = 24'h0000FF; 
	
	
	always @(posedge lcd_pclk or negedge rst_n) begin
		if(!rst_n)
			pixel_data <= BLACK;
			
		else begin
			if (dino_draw)
				pixel_data <= BLACK;  // 黑色恐龍
			else if(ground_draw)
				pixel_data <= BLACK;
			else if(cloud_draw)
				pixel_data <= BLACK;
			else if(cactus_draw)
				pixel_data <= BLACK;	
			else if(cactus_draw_2)
				pixel_data <= BLACK;
			else if(score_draw)
				pixel_data <= BLACK;
			/*else if(cactus_2_draw)
				pixel_data <= WHITE; // 暫時先不看這部分*/
			else
				pixel_data <= WHITE;  // 白色背景
		end
	end
	
endmodule