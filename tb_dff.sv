import env1_pkg::*;

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

endprogram :dff_tb

