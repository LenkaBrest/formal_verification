module okv
	(input clk,
	 input rst,
	 input wolf,
	 input sheep,
	 input cab,
	 output [3:0] state);

	logic w,s,c,t;
	always @ (posedge clk)
	    if (rst)
		begin
		   w <= 1'b0;
		   s <= 1'b0;
		   c <= 1'b0;
		   t <= 1'b0;
		end
	    else
	       begin
		  if(wolf)
		      w <= ~w;
		  if(sheep)
		      s <= ~s;
		  if(cab)
		      c <= ~c;
		  t <= ~t;
	      end

	assign state = {t, w, s, c};

	default clocking 
		@(posedge clk);
	endclocking

	
        property same_side(a, b, c);
            a |-> (b == c);
        endproperty

    assume_ss_cab :
      restrict property (same_side(cab, c, t));

    assume_ss_wolf :
      restrict property (same_side(wolf, w, t));

    assume_ss_sheep :
      restrict property (same_side(sheep, s, t));

	/*restrict property (wolf |-> (w & t));
	restrict property (sheep |-> (s & t));
	restrict property (cab |-> (c & t));*/
	restrict property (~((t & ~w & ~s) | (~t & w & s)));
	restrict property (~((t & ~s & ~c) | (~t & s & c)));


	cover property (state == 4'b1111);
endmodule
