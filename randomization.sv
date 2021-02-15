//////////////////      Randomization   ///////////////////////

// rand - to randomize variable
// randc - cyclic randomize variable (not repeat)

class packet;
  rand bit [3:0]adr;
  randc bit [7:0]data;
endclass :packet

class gen;

rand packet pkt;


task run;
pkt =new();
   repeat(6)begin
 assert(pkt.randomize());
  end
endtask :run

  function void display();
      $display("after randomization adr = %0d, data = %0d ",pkt.adr,pkt.data);
  endfunction :display

endclass :gen


module rand_methd;
gen g;

initial 
begin
g =new();
g.run();
g.display();
end
endmodule :rand_methd
