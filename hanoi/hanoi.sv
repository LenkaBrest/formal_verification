module Hanoi
    //#(parameter S = 4)
    (
     input clk,
     input rst,
     input [1:0] fr,
     input [1:0] to,
     output reg [3:0] O1,
     output reg [3:0] O2,
     output reg [3:0] O3);

     bit [0:2][4-1:0] st ;//stanje na stapovima, npr na pocetku [1111;0000;0000]


     logic [1:0] f;
     logic [1:0] t;



     always_ff @(posedge clk)
	begin
	    if(rst)
		begin
	
		st = 12'hf00;
	    
		end
	    else
		begin
		
		f <= fr;
		t <= to;
		O1 <= (st[f] & 4'b1);
		O2 <= st[1];
        O3 <= st[2];

		if((st[f] & 4'b1) == 4'b1) //prenosimo najmanju plocicu
			begin
			    O1 <= st[0] & 4'b1;
				st[f] <= st[f] & 4'b1110;
				st[t] <= st[t] | 4'b1;
				$display("%h'4", st[f]);
			end
		else if ((st[f] & 4'b0010) == 4'b0010)
			begin
				st[f] <= st[f] & 4'b1101;
				st[t] <= st[t] | 4'b0010;
			end
		else if ((st[f] & 4'b0100) == 4'b0100)
			begin
				st[f] <= st[f] & 4'b1011;
				st[t] <= st[t] | 4'b0100;
			end
		else if ((st[f] & 4'b1000) == 4'b1000)
			begin
				st[f] <= st[f] & 4'b0111;
				st[t] <= st[t] | 4'b1000;
			end
        
        

	end
    end

logic ilegal;

always_comb begin
	ilegal = 1'b0;
	if(((st[f] & 4'b0010) == 4'b0010) && ((st[t] & 4'b0001) == 4'b0001)) ilegal = 1'b1;
	if(((st[f] & 4'b0100) == 4'b0100) && ((st[t] & 4'b0011) != 4'b0000)) ilegal = 1'b1;
	if(((st[f] & 4'b1000) == 4'b1000) && ((st[t] & 4'b0111) != 4'b0000)) ilegal = 1'b1;
end

default clocking
	@(posedge clk);
endclocking

restrict property(ilegal == 1'b0);
cover property(st[2] == 4'b1111);
endmodule

	    
