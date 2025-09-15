module key_debounce(
    input clk,
    input rst_n,
    input key,
    output reg key_value,
    output reg key_flag
);


    reg key_reg; // used to compare the current key state with the previous state
    reg [18:0] debounce_counter; // use to count 20ms debounce time

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            key_reg <= 1'b1;
            debounce_counter <= 19'd0;
        end 
        else begin
            // Debounce logic here
            key_reg <= key;
            if(key_reg != key)
                debounce_counter <= 19'd50_0000;
            else if(key_reg == key && debounce_counter > 19'd0)
                debounce_counter <= debounce_counter - 1'b1;
            else
                debounce_counter <= debounce_counter;  
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            key_flag <= 1'b0;
            key_value <= 1'b1;
        end
        else begin
            if(debounce_counter == 19'd1) begin
                key_flag <= 1'b1;
                key_value <= key_reg; // output the stable key state
            end
            else begin
                key_flag <= 1'b0;
                key_value <= key_value; // maintain the last stable state
            end
        end
    
    end
endmodule