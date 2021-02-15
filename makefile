#INTER =interface.sv
#PKG =env_pkg.sv
#TOP =top.sv
FILE =dff12.sv
#probe =-input probes.tcl
#INC = +incdir+../rtl +incdir+../tb
sim1:
	#irun -uvm -sv -access +rwc -gui $(RTL) $(INTER)  #$(probe) $(TOP) $(PKG) $(INC) +UVM_VERBOSITY=UVM_MEDIUM  +UVM_TESTNAME=base_test
	irun  -sv -access +rwc  +nccoverage+all -covoverwrite   $(FILE) #$(probe) #+UVM_VERBOSITY=UVM_MEDIUM +UVM_TESTNAME=base_test

simvision:
	
	simvision & 
regress:
	make sim1  

coverage:
	irun -uvm -sv +nccoverage+all -covoverwrite $(FILE)$(probe) # +UVM_TESTNAME=base_test
	#irun -uvm -sv +nccoverage+all -covoverwrite $(RTL) $(INTER)   $(probe) $(TOP) $(PKG) $(INC) 


	
clean :
	rm -rf INCA_libs ncsim.shm open.shm irun.log irun.history *.shmi

