module okv_tb();

	logic clk = 1'b0;
	logic rst;
	logic wolf;
	logic sheep;
	logic cab;
	logic [3:0] state;

	always clk = #5 ~clk;

	initial
	   begin
	      rst <= 1'b1;
	      repeat(2)
		 @(posedge clk);
	      rst <= 1'b0;
	   end

	always @(posedge clk)
	   begin
	      wolf <= 1'b0;
	      sheep <= 1'b0;
	      cab <= 1'b0;
	      @(negedge rst);
	      forever
		  begin
		     @(posedge clk);
		     wolf = $random;
		     sheep = $random;
		     cab = $random;
		  end
	   end


	always @(posedge clk)
	   begin
	      if((cab & sheep & (state == 4'b0011)) | (~cab & ~sheep & (state == 4'b1100)))
		 $display("Cabbage and sheep can not be alone");
	      if((wolf & sheep & (state == 4'b0110)) | (~wolf & ~sheep & (state == 4'b1001)))
		 $display("Sheep and wolf can not be alone");
	   end

	okv duv(.clk(clk), .rst(rst), .wolf(wolf), .cab(cab), .state(state));

endmodule
