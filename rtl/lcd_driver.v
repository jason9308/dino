module lcd_driver(
    input                lcd_pclk,    // 像素時鐘
    input                rst_n,       // 非同步低電位有效重置
    input        [15:0]  lcd_id,      // LCD 螢幕 ID（根據型號決定時序參數）
    input        [23:0]  pixel_data,  // 當前像素的 RGB888 顏色資料
	
    output       [10:0]  pixel_xpos,  // 當前像素點 X 座標（橫向）
    output       [10:0]  pixel_ypos,  // 當前像素點 Y 座標（縱向）
    output  reg  [10:0]  h_disp,      // 水平顯示有效解析度
    output  reg  [10:0]  v_disp,      // 垂直顯示有效解析度

    // LCD 顯示接口（RGB）
    output               lcd_de,      // 資料有效（Data Enable）信號
    output               lcd_hs,      // 行同步（HSYNC），DE 模式下拉高
    output               lcd_vs,      // 場同步（VSYNC），DE 模式下拉高
    output      reg      lcd_bl,      // 背光控制，1：開
    output               lcd_clk,     // 螢幕像素時鐘
    output       [23:0]  lcd_rgb,     // 輸出 RGB 資料
    output      reg      lcd_rst      // LCD 重置訊號，1：不重置
);

	// ──────────────────────────────────────────────
	// 以下為各種 LCD 尺寸的對應時序參數（含同步、前後消隱、解析度）
	// ──────────────────────────────────────────────

	// 4.3 吋 480x272
	parameter  H_SYNC_4342   =  11'd41;
	parameter  H_BACK_4342   =  11'd2;
	parameter  H_DISP_4342   =  11'd480;
	parameter  H_FRONT_4342  =  11'd2;
	parameter  H_TOTAL_4342  =  11'd525;

	parameter  V_SYNC_4342   =  11'd10;
	parameter  V_BACK_4342   =  11'd2;
	parameter  V_DISP_4342   =  11'd272;
	parameter  V_FRONT_4342  =  11'd2;
	parameter  V_TOTAL_4342  =  11'd286;

	// 7 吋 800x480（常用）
	parameter  H_SYNC_7084   =  11'd128;
	parameter  H_BACK_7084   =  11'd88;
	parameter  H_DISP_7084   =  11'd800;
	parameter  H_FRONT_7084  =  11'd40;
	parameter  H_TOTAL_7084  =  11'd1056;

	parameter  V_SYNC_7084   =  11'd2;
	parameter  V_BACK_7084   =  11'd33;
	parameter  V_DISP_7084   =  11'd480;
	parameter  V_FRONT_7084  =  11'd10;
	parameter  V_TOTAL_7084  =  11'd525;

	// 以下省略其它尺寸註解（可類推）

	// ──────────────────────────────────────────────
	// 內部暫存器與計數器宣告
	// ──────────────────────────────────────────────
	reg  [10:0] h_sync ;
	reg  [10:0] h_back ;
	reg  [10:0] h_total;
	reg  [10:0] v_sync ;
	reg  [10:0] v_back ;
	reg  [10:0] v_total;
	reg  [10:0] h_cnt  ;     // 行計數器
	reg  [10:0] v_cnt  ;     // 場計數器

	// ──────────────────────────────────────────────
	// 資料輸出控制
	// ──────────────────────────────────────────────
	wire        lcd_en;      // 資料有效範圍（畫面區域）
	wire        data_req;    // 是否請求 pixel_data 顏色輸入

	assign lcd_hs  = 1'b1;             // DE 模式下 HSYNC 拉高
	assign lcd_vs  = 1'b1;             // DE 模式下 VSYNC 拉高
	assign lcd_clk = lcd_pclk;        // 像素時鐘直接輸出
	assign lcd_de  = lcd_en;          // LCD DE = 資料有效

	// 是否在畫面範圍內輸出資料
	assign lcd_en = (
		(h_cnt >= h_sync + h_back) &&
		(h_cnt < h_sync + h_back + h_disp) &&
		(v_cnt >= v_sync + v_back) &&
		(v_cnt < v_sync + v_back + v_disp)
	) ? 1'b1 : 1'b0;

	// 提前一個 clock 請求像素顏色資料
	assign data_req = (
		(h_cnt >= h_sync + h_back - 1) &&
		(h_cnt < h_sync + h_back + h_disp - 1) &&
		(v_cnt >= v_sync + v_back) &&
		(v_cnt < v_sync + v_back + v_disp)
	) ? 1'b1 : 1'b0;

	// 回傳目前的像素座標
	assign pixel_xpos = data_req ? (h_cnt - (h_sync + h_back - 1)) : 11'd0;
	assign pixel_ypos = data_req ? (v_cnt - (v_sync + v_back - 1)) : 11'd0;

	// 若在有效區域則輸出 pixel_data，否則為黑（0）
	assign lcd_rgb = lcd_en ? pixel_data : 24'd0;

	// ──────────────────────────────────────────────
	// 根據 LCD 型號選擇時序參數
	// ──────────────────────────────────────────────
	always @(posedge lcd_pclk) begin
		case (lcd_id)
			16'h4342: begin
				h_sync  <= H_SYNC_4342; 
				h_back  <= H_BACK_4342; 
				h_disp  <= H_DISP_4342; 
				h_total <= H_TOTAL_4342;
				v_sync  <= V_SYNC_4342; 
				v_back  <= V_BACK_4342; 
				v_disp  <= V_DISP_4342; 
				v_total <= V_TOTAL_4342;
			end
			16'h7084: begin
				h_sync  <= H_SYNC_7084; 
				h_back  <= H_BACK_7084; 
				h_disp  <= H_DISP_7084; 
				h_total <= H_TOTAL_7084;
				v_sync  <= V_SYNC_7084; 
				v_back  <= V_BACK_7084; 
				v_disp  <= V_DISP_7084; 
				v_total <= V_TOTAL_7084;
			end
			// 其它型號省略，可視情況補上
			default: begin
				h_sync  <= H_SYNC_4342; 
				h_back  <= H_BACK_4342; 
				h_disp  <= H_DISP_4342; 
				h_total <= H_TOTAL_4342;
				v_sync  <= V_SYNC_4342; 
				v_back  <= V_BACK_4342; 
				v_disp  <= V_DISP_4342; 
				v_total <= V_TOTAL_4342;
			end
		endcase
	end

	// ──────────────────────────────────────────────
	// 行計數器：每個 clock 增加一行，滿了就歸 0
	// ──────────────────────────────────────────────
	always @ (posedge lcd_pclk or negedge rst_n) begin
		if (!rst_n)
			h_cnt <= 11'd0;
		else if (h_cnt == h_total - 1)
			h_cnt <= 11'd0;
		else
			h_cnt <= h_cnt + 1;
	end

	// ──────────────────────────────────────────────
	// 場計數器：每一行結束，場才進一格
	// ──────────────────────────────────────────────
	always @ (posedge lcd_pclk or negedge rst_n) begin
		if (!rst_n)
			v_cnt <= 11'd0;
		else if (h_cnt == h_total - 1) begin
			if (v_cnt == v_total - 1)
				v_cnt <= 11'd0;
			else
				v_cnt <= v_cnt + 1;
		end
	end

	// ──────────────────────────────────────────────
	// 控制 LCD 背光與重置
	// ──────────────────────────────────────────────
	always @ (posedge lcd_pclk or negedge rst_n) begin
		if (!rst_n) begin
			lcd_rst <= 0;
			lcd_bl  <= 0;
		end
		else begin
			lcd_rst <= 1;  // 取消重置
			lcd_bl  <= 1;  // 開啟背光
		end
	end

endmodule
