module dff_top11;
bit clk;
always	#5 clk <= ~clk;

        dff_if infc(clk);
	dff_dut dut(infc);
	dff_tb tb(infc);


initial begin
     $dumpfile("tb.vcd");
     $dumpvars();
        #2000
	$finish();
end

endmodule :dff_top11

