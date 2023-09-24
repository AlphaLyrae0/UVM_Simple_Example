#VIVADO_VER := /tools/Xilinx/Vivado/2022.2
 VIVADO_VER := /tools/Xilinx/Vivado/2023.1
 VLOG := $(VIVADO_VER)/bin/xvlog
 ELAB := $(VIVADO_VER)/bin/xelab
 SIM  := $(VIVADO_VER)/bin/xsim

TOP_MODULE := mem_testbench

.PHONY : all
all :
	make run_mem_test

.PHONY : run_%
run_% : build
	./axsim.sh --testplusarg "UVM_TESTNAME=$*"
	mv xsim.log xsim_$*.log
#	$(SIM) $(TOP_MODULE) -R --testplusarg "UVM_TESTNAME=mem_test"

.PHONY: gui_%
gui_% : build_gui
	$(SIM) $(TOP_MODULE) --gui --testplusarg "UVM_TESTNAME=$*" &

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

.PHONY : build
build : ./xsim.dir/alone/axsim ./axsim.sh
./xsim.dir/alone/axsim ./axsim.sh : $(SRC_FILES) $(INC_FILES)
	$(VLOG) -L uvm -sv $(INC_OPT) $(SRC_FILES) 
	$(ELAB) $(TOP_MODULE) -L uvm -timescale 1ns/1ps --snapshot alone --standalone

.PHONY : build_gui
build_gui : ./xsim.dir/debug/xsimk
./xsim.dir/debug/xsimk : $(SRC_FILES) $(INC_FILES)
	$(VLOG) -L uvm -sv $(INC_OPT) $(SRC_FILES) 
	$(ELAB) $(TOP_MODULE) -L uvm -timescale 1ns/1ps --snapshot debug --debug typical

.PHONY: clean
clean:
	rm -fr xsim.dir axsim.sh .Xil
	rm -fr *.pb
	rm -rf *.log *.jou *.str
	rm -fr *.vcd *.wdb

.PHONY : git_add
git_add :
	git add .
	git status
	git commit

.PHONY : git_push
git_push :
	git push

