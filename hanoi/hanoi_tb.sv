`timescale 1ns / 1ps

module hanoi_tb ();

//parameter S = 4;

logic clk;
logic rst;
logic [1 : 0] fr;
logic [1 : 0] to;
logic [3:0] O1;
logic [3:0] O2;
logic [3:0] O3;


Hanoi han(.clk(clk), .rst(rst), .fr(fr), .to(to), .O1(O1), .O2(O2), .O3(O3));
always begin
    #10ns clk = ~clk; 
end

initial begin
    rst = 1;
    clk = 0;
    #30ns;
    rst = 0;
end

initial begin
  repeat(4) begin
    @(posedge clk) begin
        fr <= 0;
        to <= 1;
    end
    @(posedge clk) begin
        fr <= 0;
        to <= 1;
    end
    @(posedge clk) begin
        fr <= 0;
        to <= 2;
    end
    @(posedge clk) begin
        fr <= 1;
        to <= 0;
    end
    @(posedge clk) begin
        fr <= 2;
        to <= 1;
    end
    @(posedge clk) begin
        fr <= 0;
        to <= 1;
    end
  end
end
   

endmodule