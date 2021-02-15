INTER =interface.sv
PKG =env_pkg.sv
TOP =top.sv
RTL =apb_slave.v
probe =-input probes.tcl
#INC = +incdir+../rtl +incdir+../tb
sim1:
	#irun -uvm -sv -access +rwc -gui $(RTL) $(INTER)  $(probe) $(TOP) $(PKG) $(INC) +UVM_VERBOSITY=UVM_MEDIUM  +UVM_TESTNAME=base_test
	irun  -uvm -sv -access +rwc  $(PKG)  $(TOP) $(INTER) $(RTL) $(probe) +UVM_VERBOSITY=UVM_MEDIUM +UVM_TESTNAME=base_test

sim2:
	#irun -uvm -sv -access +rwc -gui $(RTL) $(INTER) $(probe) $(TOP) $(PKG)  $() +UVM_VERBOSITY=UVM_MEDIUM  +UVM_TESTNAME=test2
	irun -uvm -sv -access +rwc $(RTL) $(INTER)  $(PKG) $(TOP) $(probe) +UVM_VERBOSITY=UVM_MEDIUM +UVM_TESTNAME=test2
sim3:
	#irun -uvm -sv -access +rwc -gui $(RTL) $(INTER) $(PKG) $(TOP) $(probe) +UVM_VERBOSITY=UVM_MEDIUM  +UVM_TESTNAME=test3
	irun -uvm -sv -access +rwc $(RTL) $(INTER)   $(PKG) $(TOP)  $(probe) +UVM_VERBOSITY=UVM_MEDIUM +UVM_TESTNAME=test3
sim4:
	#irun -uvm -sv -access +rwc -gui $(RTL) $(INTER) $(PKG) $(TOP) $(probe) +UVM_VERBOSITY=UVM_MEDIUM  +UVM_TESTNAME=test1
	irun -uvm -sv -access +rwc $(RTL) $(INTER)    $(PKG) $(TOP) $(probe) +UVM_VERBOSITY=UVM_MEDIUM +UVM_TESTNAME=test4 

simvision:
	
	simvision & 
regress:
	make sim1 sim2 sim3 sim4 

coverage:
	irun -uvm -sv +nccoverage+all -covoverwrite $(RTL) $(INTER)  $(TOP) $(PKG) $(probe) $(INC)+UVM_TESTNAME=base_test
	#irun -uvm -sv +nccoverage+all -covoverwrite $(RTL) $(INTER)   $(probe) $(TOP) $(PKG) $(INC) 


	
clean :
	rm -rf INCA_libs ncsim.shm open.shm irun.log irun.history *.shmi

