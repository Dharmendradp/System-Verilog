/*
class base_pkt;
 randc bit [1:0]din;
 bit rst;
 bit [1:0]q;
 
function void Display(string name);
         $display("--------------------------------------------");
          $display("       %s   ",name);
          $display("-------------------------------------------");
          $display("Data_in = %0d, Data_out = %0d , Reset = %0d",din,q,rst);
          $display("------------------------------------------");
endfunction :Display

endclass :base_pkt


class generator;
  base_pkt pkt;
  mailbox gen2drv;
 // int  repeat_count;
function new(base_pkt pkt, mailbox gen2drv);
         this.pkt = pkt;
         this.gen2drv = gen2drv;
endfunction 
task run();
         //   repeat(repeat_count) 
              begin	
              assert (pkt.randomize());
	      gen2drv.put(pkt);
              pkt.Display("generator");
              end
endtask :run
endclass :generator


class driver;
	base_pkt pkt;     
        mailbox gen2drv;
	virtual intf vif;
function new (base_pkt pkt,mailbox gen2drv,virtual intf vif);
         this.pkt = pkt;
         this.gen2drv = gen2drv;
         this.vif = vif;
endfunction 
task run();
	forever begin
	     gen2drv.get(pkt);
             vif.rst = 1;
             vif.din = pkt.din;	
          // vif.rst = pkt.rst
             pkt.Display("driver");
	end
endtask :run
endclass :driver


class monitor1;      // observes if any changes to input
	base_pkt pkt;     
        mailbox mon12ref;
	virtual intf vif;
function new (base_pkt pkt,mailbox mon12ref,virtual intf vif);
         this.pkt = pkt;
         this.mon12ref = mon12ref;
         this.vif = vif;
endfunction 
task run();
	forever begin
          @(vif.cb)
	     pkt.din = vif.din;
             mon12ref.put(pkt);
             pkt.Display("monitor 1");
	end
endtask :run
endclass



class monitor2;         // observes if any changes to input
	base_pkt pkt;     
        mailbox mon22sb;
	virtual intf vif;
function new (base_pkt pkt,mailbox mon22sb,virtual intf vif);
         this.pkt = pkt;
         this.mon22sb = mon22sb;
         this.vif = vif;
endfunction 
task run();
	forever begin
          @(vif.cb)
	     pkt.q = vif.q;
             mon22sb.put(pkt);
             pkt.Display("monitor 2");
	end
endtask :run
endclass


class ref_model;    
	base_pkt pkt;     
        mailbox mon12ref;
        mailbox ref2sb;
function new (base_pkt pkt,mailbox mon12ref,mailbox ref2sb);
         this.pkt = pkt;
         this.mon12ref = mon12ref;
         this.ref2sb = ref2sb;
endfunction 
task run();
	forever begin
             mon12ref.get(pkt);
            if (pkt.rst == 1) begin
                pkt.q = pkt.din;
            end
             ref2sb.put(pkt);
             pkt.Display("Reference model");
	end
endtask :run
endclass


class scoreboard;    
	base_pkt pkt1;
        base_pkt pkt2;     
        mailbox mon22sb;
        mailbox ref2sb;
function new (base_pkt pkt1,base_pkt pkt2,mailbox mon22sb,mailbox ref2sb);
         this.pkt1 = pkt1;
         this.pkt2 = pkt2;
         this.mon22sb = mon22sb;
         this.ref2sb = ref2sb;
endfunction 
task run();
	forever begin
         ref2sb.get(pkt1);
         mon22sb.get(pkt2);
         #5;
         if(pkt2.q == pkt1.din)
            $display ("Successfully matched pkt2.q = %d , pkt1.din = %d ",pkt2.q, pkt1.din);
        else
            $display ("NOT matched pkt2.q = %d , pkt1.din = %d ",pkt2.q, pkt1.din);
             
        //pkt.Display("Reference model");
	end
endtask :run
endclass


program dff_tb(intf.tb vif);    
        base_pkt pkt;
        base_pkt pkt1;
        base_pkt pkt2;
	generator gen;
	driver drv;
	monitor1 mon1;
	monitor2 mon2;
        ref_model r_model;
	scoreboard sbd;
        mailbox gen2drv;
        mailbox mon12ref;
        mailbox mon22sb;
        mailbox ref2sb;
initial begin
       pkt = new();
       pkt1 = new();
       pkt2 = new();
       gen2drv = new();
       mon12ref= new();
       mon22sb = new();
       ref2sb = new();
       gen = new(pkt,gen2drv);
       drv = new(pkt,gen2drv,vif);
       mon1 = new(pkt,mon12ref,vif);
       mon2 = new(pkt,mon22sb,vif);
       r_model = new(pkt,mon12ref,ref2sb);
       sbd = new(pkt1,pkt2,mon22sb,ref2sb);
end
initial begin
repeat(10)
      fork
     gen.run();
     drv.run();
     mon1.run();
     mon2.run();
     r_model.run();
     sbd.run();
join
end
endprogram


/module d_ff(intf.dut vif);
always @(posedge vif.clk)
begin
if(vif.rst==0)
vif.Q=0;
else
vif.Q=vif.Din;
end
endmodule/


module d_ff(input [1:0]din, 
            input rst,clk, 
            output reg [1:0]q);
always @(posedge clk) begin
  if (rst == 1)      
    q <= 0;
  else
    q <= din;
end

endmodule :d_ff


interface intf(input logic clk);
	logic [1:0]din;
	logic [1:0]q;
        logic rst;
clocking cb@(posedge clk);
      default input #1ns output #1ns;
      output rst,din;
      input q;
endclocking 	
modport dut(input din,rst,clk, output q);
modport tb(output rst,din, input q,clk);
endinterface


module dff_top();
bit clk;
//bit rst;
 
always	#5 clk=~clk;
 
///reset Generation
  initial begin
    rst = 1;
    #5 rst =0;
  end////
	intf vif(clk);
	d_ff dut(.din(vif.din),.rst(vif.rst),.q(vif.q),clk(vif.clk));
	dff_tb tb(vif);


initial begin
//	$dumpfile("tb.vcd");
  //      $dumpvars();
        #2000
	$finish();
end


endmodule*/

class base_pkt;
randc bit [1:0]Din;
bit rst;
bit [1:0]Q;
endclass

class tx_gen;
base_pkt pkt;
mailbox tx2drv;
function new(base_pkt pkt,mailbox tx2drv);
this.pkt=pkt;
this.tx2drv=tx2drv;
endfunction
task tx_run();
begin
assert(pkt.randomize());
tx2drv.put(pkt);
end
endtask
endclass

class driver;
base_pkt pkt;
mailbox tx2drv,drv2sb;
virtual dff_if infc;
function new(base_pkt pkt,mailbox tx2drv,drv2sb, virtual dff_if infc);
this.pkt=pkt;
this.tx2drv=tx2drv;
this.drv2sb=drv2sb;
this.infc=infc;
endfunction
task drv_run();
begin
tx2drv.get(pkt);
infc.rst=1;
infc.Din=pkt.Din;
drv2sb.put(pkt);
end
endtask
endclass

class monitor;
base_pkt pkt;
mailbox mon2sb;
virtual dff_if infc;
function new(base_pkt pkt,mailbox mon2sb, virtual dff_if infc);
this.pkt=pkt;
this.mon2sb=mon2sb;
this.infc=infc;
endfunction
task mon_run();
begin
@(infc.cb)
pkt.Q=infc.Q;
mon2sb.put(pkt);
end
endtask
endclass

class scoreboard;
base_pkt pkt1,pkt2;
mailbox drv2sb,mon2sb;
function new(base_pkt pkt1,pkt2,mailbox drv2sb,mon2sb);
this.pkt1=pkt1;
this.pkt2=pkt2;
this.drv2sb=drv2sb;
this.mon2sb=mon2sb;
endfunction
task sb_run();
begin
mon2sb.get(pkt2);
drv2sb.get(pkt1);
#10
if(pkt2.Q==pkt1.Din)
$display("matched pkt2.Q=%b pkt1.Din=%b",pkt2.Q,pkt1.Din);
else
$display("notmatched pkt2.Q=%b pkt1.Din=%b",pkt2.Q,pkt1.Din);
end
endtask
endclass

program dff_tb(dff_if.tb infc);
base_pkt pkt1,pkt2;
tx_gen tx;
driver drv;
monitor mon;
scoreboard sb;
mailbox tx2drv,drv2sb,mon2sb;
initial
begin
pkt1=new();
pkt2=new();
tx2drv=new();
drv2sb=new();
mon2sb=new();
tx=new(pkt1,tx2drv);
drv=new(pkt1,tx2drv,drv2sb,infc);
mon=new(pkt2,mon2sb,infc);
sb=new(pkt1,pkt2,drv2sb,mon2sb);
end
initial 
begin
repeat(10)
fork
tx.tx_run();
drv.drv_run();
#3 mon.mon_run();
sb.sb_run();
join
end
endprogram

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
endinterface

module dff_dut(dff_if.dut infc);
always@(posedge infc.clk)
begin
if(infc.rst==0)
infc.Q=0;
else
infc.Q=infc.Din;
end
endmodule

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

