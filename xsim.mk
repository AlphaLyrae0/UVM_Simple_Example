
include common.mk

#VIVADO_VER := /tools/Xilinx/Vivado/2022.2
 VIVADO_VER := /tools/Xilinx/Vivado/2023.1
 VLOG := $(VIVADO_VER)/bin/xvlog
 ELAB := $(VIVADO_VER)/bin/xelab
 SIM  := $(VIVADO_VER)/bin/xsim

#-------- For Internal UVM ----------
 VLOG_OPT := -L uvm
 ELAB_OPT := -L uvm
#------------------------------------
#-------- For External UVM ----------
#UVM_PATH := $(HOME)/UVM/uvm-1.2
#UVM_PATH := $(HOME)/UVM/1800.2-2020-2.0
#VLOG_OPT := --define UVM_NO_DPI --include $(UVM_PATH)/src $(UVM_PATH)/src/uvm_pkg.sv
#ELAB_OPT :=
#------------------------------------

.PHONY : all build build_gui run gui run_% gui_%
all :
	make run_mem_test

build :
	make -B ./xsim.dir/$(TOP_MODULE).alone/axsim ./axsim.sh
build_gui :
	make -B ./xsim.dir/$(TOP_MODULE).debug/xsimk

run : ./xsim.dir/$(TOP_MODULE).alone/axsim ./axsim.sh
	./axsim.sh --testplusarg UVM_TESTNAME=$(TEST_NAME)
	mv xsim.log xsim_$(TEST_NAME).log
#	$(SIM) $(TOP_MODULE).debug -R --testplusarg UVM_TESTNAME=mem_test

gui : ./xsim.dir/$(TOP_MODULE).debug/xsimk
	$(SIM) $(TOP_MODULE).debug --gui --testplusarg UVM_TESTNAME=$(TEST_NAME) &

run_% : 
	make run TEST_NAME=$*
gui_% :
	make gui TEST_NAME=$*

VLOG_OPT += --include ./Agent
VLOG_OPT += --include ./Env
VLOG_OPT += --include ./Seq
VLOG_OPT += --include ./Test

./xsim.dir/$(TOP_MODULE).alone/axsim ./axsim.sh : $(SRC_FILES) $(INC_FILES)
	$(VLOG) -sv $(VLOG_OPT) $(SRC_FILES) 
	$(ELAB) $(TOP_MODULE) $(ELAB_OPT) -timescale 1ns/1ps --snapshot $(TOP_MODULE).alone --standalone

./xsim.dir/$(TOP_MODULE).debug/xsimk : $(SRC_FILES) $(INC_FILES)
	$(VLOG) -sv $(VLOG_OPT) $(SRC_FILES) 
	$(ELAB) $(TOP_MODULE) $(ELAB_OPT) -timescale 1ns/1ps --snapshot $(TOP_MODULE).debug --debug typical

.PHONY: clean
clean:
	rm -fr xsim.dir axsim.sh .Xil
	rm -fr *.pb
	rm -rf *.log *.jou *.str
	rm -fr *.vcd *.wdb