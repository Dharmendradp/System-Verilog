interface dff_if(input clk);
logic rst;
logic [1:0]Din;
logic [1:0]Q;
clocking cb@(posedge clk);
default input #1ns output #1ns;
output rst,Din;
input Q;
endclocking
modport dut(input rst,Din,clk,output Q);
modport tb(output rst,Din,clk,input Q);
endinterface :dff_if

