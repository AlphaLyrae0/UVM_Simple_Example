#VIVADO_VER := /tools/Xilinx/Vivado/2022.2
 VIVADO_VER := /tools/Xilinx/Vivado/2023.1
 VLOG := $(VIVADO_VER)/bin/xvlog
 ELAB := $(VIVADO_VER)/bin/xelab
 SIM  := $(VIVADO_VER)/bin/xsim

 UVM_OPT := -L uvm
#UVM_PATH := $(HOME)/UVM/uvm-1.2
#UVM_PATH := $(HOME)/UVM/1800.2-2020-2.0
#UVM_OPT := --define UVM_NO_DPI --include $(UVM_PATH)/src $(UVM_PATH)/src/uvm_pkg.sv

TOP_MODULE := mem_testbench
TEST_NAME  := mem_test 

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

SRC_FILES += ./DUT/memory.sv
SRC_FILES += ./Agent/mem_agent_pkg.sv ./Agent/mem_if.sv
SRC_FILES += ./Env/mem_env_pkg.sv
SRC_FILES += ./Seq/mem_sequence_lib_pkg.sv
SRC_FILES += ./Test/mem_test_lib_pkg.sv
SRC_FILES += ./TB/mem_testbench.sv

INC_FILES += $(shell ls ./Agent/*.svh)
INC_FILES += $(shell ls ./Env/*.svh)

INC_OPT += --include ./Agent
INC_OPT += --include ./Env
INC_OPT += --include ./Seq
INC_OPT += --include ./Test

./xsim.dir/$(TOP_MODULE).alone/axsim ./axsim.sh : $(SRC_FILES) $(INC_FILES)
	$(VLOG) -sv $(UVM_OPT) $(INC_OPT) $(SRC_FILES) 
	$(ELAB) $(TOP_MODULE) -L uvm -timescale 1ns/1ps --snapshot $(TOP_MODULE).alone --standalone

./xsim.dir/$(TOP_MODULE).debug/xsimk : $(SRC_FILES) $(INC_FILES)
	$(VLOG) -sv $(UVM_OPT) $(INC_OPT) $(SRC_FILES) 
	$(ELAB) $(TOP_MODULE) -L uvm -timescale 1ns/1ps --snapshot $(TOP_MODULE).debug --debug typical

.PHONY: clean
clean:
	rm -fr xsim.dir axsim.sh .Xil
	rm -fr *.pb
	rm -rf *.log *.jou *.str
	rm -fr *.vcd *.wdb

.PHONY : git_add git_push
git_add :
	git add .
	git status
	git commit

git_push :
	git push

