module and_dut (input [3:0]a,b, output [7:0]y);
	assign y= a * b;
endmodule

// in cofig_db, we need to declare all mailboxes
class config_db;
	static virtual intf vif;
	static mailbox gen2drv =new();
	static mailbox mon12cov =new();
	static mailbox mon12ref =new();
	static mailbox mon22sb=new();
	static mailbox ref2sb=new();
endclass

class base_pkt;
	rand bit [3:0]a;
	rand bit [3:0]b;
 	bit [7:0]y;

     function void Display(string name);
          $display("------------------------");
          $display("       %s   ",name);
          $display("------------------------");
          $display("a = %0d, b = %0d , y = %0d",a,b,y);
          $display("------------------------");
     endfunction :Display

endclass

class generator;
	base_pkt pkt;
       int  repeat_count;

         task run();
            repeat(repeat_count) 
               begin	
		pkt=new();
              	assert (pkt.randomize());
                pkt.Display("generator");
		config_db::gen2drv.put(pkt);
              end
endtask :run
      
endclass

class driver;
	base_pkt pkt;     //virtual interface- doesn't have memory
	virtual intf vif;

	task run();
		this.vif = config_db::vif;
		forever begin
			config_db::gen2drv.get(pkt);
                    //   pkt.a = 1;
			vif.a = pkt.a;
			vif.b = pkt.b;	
                        pkt.Display("driver");
		end
	endtask

endclass

class monitor1;
	base_pkt pkt;
	virtual intf vif;

	task run();
		this.vif= config_db::vif;

               	//forever @(vif.a or vif.b) begin
		forever begin
                 	#1;
			pkt = new();
			pkt.a=vif.a;
			pkt.b=vif.b;
                        pkt.Display("monitor1");
			config_db::mon12cov.put(pkt);
			config_db::mon12ref.put(pkt); 
		end
	endtask
endclass

class monitor2;
	base_pkt pkt;
	virtual intf vif;

	task run();
		this.vif= config_db::vif;
	//	forever @(vif.a or vif.b) begin
		forever begin
                	#1;
			pkt= new();
			pkt.y = vif.y;
                        pkt.Display("monitor2");
			config_db::mon22sb.put(pkt);
		end
	endtask
endclass	

class coverage;
 task run();
 
 endtask
endclass

// sample of your dut
class ref_model;
	base_pkt pkt;

	task run();
		forever begin
                       // pkt =new();
			config_db::mon12ref.get(pkt);
			pkt.y=pkt.a * pkt.b;
                     pkt.Display("ref_model");
			config_db::ref2sb.put(pkt);
		end
	endtask
	
endclass

class scoreboard;
base_pkt pkt1,pkt2;

task run();
	forever begin
		config_db::ref2sb.get(pkt1);
		config_db::mon22sb.get(pkt2);
		if(pkt1.y==pkt2.y) $display ("comparison done");
		else $display ("comparison failed");
               pkt2.Display("Scoreboard");
	end	
endtask
endclass

class environment;
	generator gen;
	driver drv;
	monitor1 mon1;
	monitor2 mon2;
	coverage cov;
	ref_model r_model;
	scoreboard sbd;
  //     config_db cfg_db;


	function new();
		gen=new();
		drv=new();
		mon1=new();
		mon2=new();
		cov=new();
		r_model=new();
		sbd=new();
	endfunction

	task run();
		fork
			gen.run();
			drv.run();
			mon1.run();
			mon2.run();
			cov.run();
			r_model.run();
			sbd.run();
		join
	endtask	
endclass

interface intf;
	logic [3:0]a;
	logic [3:0]b;
        logic [7:0]y;
	
	modport and_dut(input a,b,output y);
	modport testbench(output y, input a,b);
endinterface

program testbench;
	environment env;
	initial begin
		env=new();
             env.gen.repeat_count = 10;
		env.run();
	end
        
endprogram

module top;
intf pif();
and_dut dut(.a(pif.a),.b(pif.b),.y(pif.y));
testbench tb();

initial config_db::vif = pif;

initial begin
//	$dumpfile("tb.vcd");
  //      $dumpvars();
        #20
	$finish();
end

endmodule





