module dino(
	input	sys_clk,     // 系統時鐘
	input	sys_rst_n,   // 系統重置信號（低有效）
	input	key,

	// RGB LCD 介面
	output	lcd_de,      // LCD 資料使能信號（Data Enable）
	output	lcd_hs,      // LCD 行同步訊號（Horizontal Sync）
	output  lcd_vs,      // LCD 幀同步訊號（Vertical Sync）
	output  lcd_clk,     // LCD 像素時脈
	inout	[23:0]  lcd_rgb,     // LCD RGB888 顏色資料
	output	lcd_bl,      // LCD 背光控制信號（Backlight）
	output	lcd_rst      // LCD 重置信號
);

	wire [15:0] lcd_id;
	wire lcd_pclk;
	wire clk_100;
	wire clk_60;
	wire [10:0] pixel_xpos;
	wire [10:0] pixel_ypos;
	wire [10:0]  h_disp;
	wire [10:0]  v_disp;
	wire [23:0]  pixel_data;
	wire [23:0]  lcd_rgb_o;
	wire [23:0]  lcd_rgb_i;
	wire dino_draw;
	wire ground_draw;
	wire cloud_draw;
	wire [4:0] random_five;
	wire [2:0] random_three;
	wire cactus_draw;
	wire cactus_draw_2;
	wire score_draw;
	//wire cactus_2_draw;
	
	wire key_flag;
	wire key_value;
	
	wire is_living;
	wire is_dying;
	wire [3:0] move_rate;
	
	assign lcd_rgb = lcd_de ?  lcd_rgb_o :  {24{1'bz}};
	assign lcd_rgb_i = lcd_rgb;
	
	
	rd_id u_rd_id(
		.clk(sys_clk),
		.rst_n(sys_rst_n),
		.lcd_rgb(lcd_rgb_i),
		.lcd_id(lcd_id)
    );
	
	clk_div u_clk_div(
		.clk(sys_clk),
		.rst_n(sys_rst_n),
		.lcd_id(lcd_id),
		.lcd_pclk(lcd_pclk),
		.clk_60(clk_60)
	);
	
	lcd_display u_lcd_display(
		.lcd_pclk(lcd_pclk),
		.rst_n(sys_rst_n),
		.pixel_xpos(pixel_xpos),
		.pixel_ypos(pixel_ypos),
		.h_disp(h_disp),
		.v_disp(v_disp),
		.dino_draw(dino_draw),
		.ground_draw(ground_draw),
		.cloud_draw(cloud_draw),
		.cactus_draw(cactus_draw),
		.cactus_draw_2(cactus_draw_2),
		.score_draw(score_draw),
		//.cactus_2_draw(cactus_2_draw),
		.pixel_data(pixel_data)
    ); 
	
	lcd_driver u_lcd_driver(
		.lcd_pclk(lcd_pclk),
		.rst_n(sys_rst_n),
		.lcd_id(lcd_id),
		.pixel_data(pixel_data),
		.pixel_xpos(pixel_xpos),
		.pixel_ypos(pixel_ypos),
		.h_disp(h_disp),
		.v_disp(v_disp),
		.lcd_de(lcd_de),
		.lcd_hs(lcd_hs),
		.lcd_vs(lcd_vs),
		.lcd_clk(lcd_clk),
		.lcd_rgb(lcd_rgb_o),
		.lcd_rst(lcd_rst),
		.lcd_bl(lcd_bl)
	);

	dino_crtl u_dino_crtl(
		.lcd_pclk(lcd_pclk),
		.rst_n(sys_rst_n),
		.pixel_xpos(pixel_xpos),
		.pixel_ypos(pixel_ypos),
		.key_flag(key_flag),
		.key_value(key_value),
		.is_living(is_living),
		.is_dying(is_dying),
		.dino_draw(dino_draw),
		.clk_100(clk_100)
	);
	
	ground u_ground(
		.lcd_pclk(lcd_pclk),
		.clk_100(clk_100),
		.rst_n(sys_rst_n),
		.pixel_xpos(pixel_xpos),
		.pixel_ypos(pixel_ypos),
		.is_living(is_living),
		.move_rate(move_rate),
		.ground_draw(ground_draw)
	);
	
	cloud u_cloud(
		.lcd_pclk(lcd_pclk),
		.clk_100(clk_100),
		.rst_n(sys_rst_n),
		.pixel_xpos(pixel_xpos),
		.pixel_ypos(pixel_ypos),
		.random_five(random_five),
		.random_three(random_three),
		.is_living(is_living),
		.move_rate(move_rate),
		.cloud_draw(cloud_draw)
	);
	
	random_5 u_random_5(
		.lcd_pclk(lcd_pclk),
		.clk_100(clk_100),
		.rst_n(sys_rst_n),
		.q(random_five)
	);
	
	random_3 u_random_3(
		.lcd_pclk(lcd_pclk),
		.clk_100(clk_100),
		.rst_n(sys_rst_n),
		.q(random_three)
	);
	
	cactus u_cactus(
		.lcd_pclk(lcd_pclk),
		.clk_100(clk_100),
		.rst_n(sys_rst_n),
		.pixel_xpos(pixel_xpos),
		.pixel_ypos(pixel_ypos),
		.random_five(random_five),
		.random_three(random_three),
		.is_living(is_living),
		.move_rate(move_rate),
		.cactus_draw(cactus_draw),
		.cactus_draw_2(cactus_draw_2)
	);
	
	score u_score(
		.clk_100(clk_100),
		.rst_n(sys_rst_n),
		.pixel_xpos(pixel_xpos),
		.pixel_ypos(pixel_ypos),
		.is_living(is_living),
		.score_draw(score_draw)
	);
	
	/*cactus_2 u_cactus_2(
		.lcd_pclk(lcd_pclk),
		.clk_100(clk_100),
		.rst_n(sys_rst_n),
		.pixel_xpos(pixel_xpos),
		.pixel_ypos(pixel_ypos),
		.random_five(random_five),
		.random_three(random_three),
		.is_living(is_living),
		.move_rate(move_rate),
		.cactus_2_draw(cactus_2_draw)
	);*/
	
	key_debounce u_key_debounce(
		.clk(lcd_pclk), 
		.rst_n(sys_rst_n), 
		.key(key),
		.key_flag(key_flag), 
		.key_value(key_value)
	);
	
	game_crtl u_game_crtl(
		.lcd_pclk(lcd_pclk),
		.clk_100(clk_100),
	    .rst_n(sys_rst_n),
		.dino_draw(dino_draw),
		.cactus_draw(cactus_draw),
		.cactus_draw_2(cactus_draw_2),
		.key_flag(key_flag),
		.key_value(key_value),
		.move_rate(move_rate),
		.is_living(is_living),
		.is_dying(is_dying)
	);
	
endmodule