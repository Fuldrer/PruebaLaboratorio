`include "VGADefines.vh"

module VGA640x480(
    input reset,
    input clk,
    output[2:0] red,
    output[2:0] green,
    output[1:0] blue,
    output hsync,
    output vsync
);
    reg [10:0] hcount /*verilator public*/;
    reg [9:0] vcount /*verilator public*/;
    reg hsyncr;
    reg vsyncr;
    reg [7:0] rgb;
    reg [2:0] red2;
    reg [2:0] green2;
    reg [1:0] blue2;

    assign red = red2;
    assign blue = blue2;
    assign green = green2;
    assign hsync = hsyncr;
    assign vsync = vsyncr;
    
    always @ (posedge clk or posedge reset)
    begin
        if (reset)
        begin
            hcount <= 11'h0;
            vcount <= 10'h0;
            vsyncr <= 1'b0;
            hsyncr <= 1'b0;
        end
        else begin
            if (hcount == `VGA_HLIMIT) begin
                hcount <= 0;
                
                if (vcount == `VGA_VLIMIT)
                    vcount <= 0;
                else
                    vcount <= vcount + 1;
            end
            else
                hcount <= hcount + 1;
                
            if ((vcount >= `VGA_VSYNC_PULSE_START) && (vcount < `VGA_VSYNC_PULSE_END))
                vsyncr <= 0; //Vertical sync pulse (positive pulse)
            else
                vsyncr <= 1;
                
            if ((hcount >= `VGA_HSYNC_PULSE_START) && (hcount < `VGA_HSYNC_PULSE_END))
                hsyncr <= 0; //Horizontal sync pulse (positive pulse)
            else
                hsyncr <= 1;
            
            if ((hcount < `VGA_WIDTH) && (vcount < `VGA_HEIGHT))
            begin
                assign red2 = 3'b111;
                assign green2 = 3'b111;
                assign blue2 = 2'b11;
                if(vcount >= 10'd100 && vcount < 10'd200 && hcount >= 11'd100 && hcount < 11'd300) begin 
                    
                assign red2 = 3'b111;
                assign green2 = 3'b000;
                assign blue2 = 2'b00;           
                    if(vcount >= 10'd101 && vcount < 10'd199 && hcount >= 11'd101 && hcount < 11'd299)begin
                        
                        assign red2 = 3'b111;
                        assign green2 = 3'b111;
                        assign blue2 = 2'b11;
                        end
                /* 
                   TODO: Draw a rectangle from (100,100) to (300, 200) in red color. 
                   The background should white.
                */
                end
            end
            else
                rgb <= 8'h00;
            end
    end
endmodule
