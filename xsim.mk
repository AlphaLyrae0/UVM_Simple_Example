
include common.mk

#VIVADO_VER  := 2022.2
 VIVADO_VER  := 2023.1
 VIVADO_HOME := /tools/Xilinx/Vivado/$(VIVADO_VER)
 XVLOG := $(VIVADO_HOME)/bin/xvlog
 XELAB := $(VIVADO_HOME)/bin/xelab
 XSIM  := $(VIVADO_HOME)/bin/xsim

 TARGET := ./xsim.dir/$(TOP_MODULE)/xsimk
#run : $(TARGET)
#	$(XSIM) $(TOP_MODULE) -testplusarg UVM_TESTNAME=$(TEST_NAME) -R
run :
	rm ./all.wdb
	make ./all.wdb
./all.wdb : $(TARGET) ./dump_wdb.tcl
	$(XSIM) $(TOP_MODULE) -testplusarg UVM_TESTNAME=$(TEST_NAME) -tclbatch dump_wdb.tcl -wdb ./all.wdb

gui : $(TARGET)
	$(XSIM) $(TOP_MODULE) -testplusarg UVM_TESTNAME=$(TEST_NAME) -gui &

log :
	code xsim.log

wave : ./all.wdb
	$(XSIM) all.wdb -gui &

clean :
	rm -fr xsim.dir axsim.sh .Xil *.pb *.log *.jou *.str *.vcd *.wdb dump_wdb.tcl

help  :
	$(XVLOG) -help; $(XELAB) -help; $(XSIM) -help

build :
	make -B $(TARGET)

#-------- For Internal UVM ----------
 VLOG_OPT := -L uvm
 ELAB_OPT := -L uvm
#------------------------------------
#-------- For External UVM ----------
#UVM_PATH := $(HOME)/UVM/uvm-1.2
#UVM_PATH := $(HOME)/UVM/1800.2-2020-2.0
#VLOG_OPT := -define UVM_NO_DPI -include $(UVM_PATH)/src $(UVM_PATH)/src/uvm_pkg.sv
#ELAB_OPT :=
#------------------------------------
VLOG_OPT += --include ./Agent
VLOG_OPT += --include ./Env
VLOG_OPT += --include ./Seq
VLOG_OPT += --include ./Test
$(TARGET) : $(SRC_FILES) $(INC_FILES)
	$(XVLOG) -sv $(VLOG_OPT) $(SRC_FILES) 
	$(XELAB) $(TOP_MODULE) $(ELAB_OPT) -timescale 1ns/1ps -snapshot $(TOP_MODULE) -debug typical

./dump_wdb.tcl :
	echo 'log_wave -r *'  > $@
	echo 'run all'       >> $@
	echo 'quit'          >> $@



#------------ For Alone Run --------------------
TARGET_ALONE := ./xsim.dir/$(TOP_MODULE).alone/axsim ./axsim.sh
alone : $(TARGET_ALONE)
	./axsim.sh -testplusarg UVM_TESTNAME=$(TEST_NAME)

build_alone :
	make -B $(TARGET_ALONE)

$(TARGET_ALONE) : $(SRC_FILES) $(INC_FILES)
	$(XVLOG) -sv $(VLOG_OPT) $(SRC_FILES) 
	$(XELAB) $(TOP_MODULE) $(ELAB_OPT) -timescale 1ns/1ps -snapshot $(TOP_MODULE).alone -standalone
