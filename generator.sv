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
endclass :tx_gen

