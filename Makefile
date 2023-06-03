 VIVADO_VER := /tools/Xilinx/Vivado/2022.2
 VLOG := $(VIVADO_VER)/bin/xvlog
 ELAB := $(VIVADO_VER)/bin/xelab
 SIM  := $(VIVADO_VER)/bin/xsim

TOP_MODULE := mem_testbench
WORKLIB    := ./xsim.dir/work

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


.PHONY : dut
dut : $(WORKLIB)/memory.sdb
$(WORKLIB)/memory.sdb : ./DUT/memory.sv
	$(VLOG) -sv $< -L uvm

.PHONY : agent
agent : $(WORKLIB)/mem_if.sdb $(WORKLIB)/mem_agent_pkg.sdb
$(WORKLIB)/mem_if.sdb : ./Agent/mem_if.sv
	$(VLOG) -sv $< -L uvm
$(WORKLIB)/mem_agent_pkg.sdb : ./Agent/mem_agent.svh
$(WORKLIB)/mem_agent_pkg.sdb : ./Agent/mem_driver.svh
$(WORKLIB)/mem_agent_pkg.sdb : ./Agent/mem_monitor.svh
$(WORKLIB)/mem_agent_pkg.sdb : ./Agent/mem_sequencer.svh
$(WORKLIB)/mem_agent_pkg.sdb : ./Agent/mem_seq_item.svh
$(WORKLIB)/mem_agent_pkg.sdb : ./Agent/mem_agent_pkg.sv
	$(VLOG) -sv $< -L uvm --include ./Agent

.PHONY : env
env : $(WORKLIB)/mem_env_pkg.sdb
$(WORKLIB)/mem_env_pkg.sdb : ./Env/mem_scoreboard.svh
$(WORKLIB)/mem_env_pkg.sdb : ./Env/mem_env.svh
$(WORKLIB)/mem_env_pkg.sdb : ./Env/mem_env_pkg.sv
	make $(WORKLIB)/mem_agent_pkg.sdb
	$(VLOG) -sv $< -L uvm --include ./Env

.PHONY : seq
seq : $(WORKLIB)/mem_sequence_lib_pkg.sdb
$(WORKLIB)/mem_sequence_lib_pkg.sdb : ./Seq/mem_sequence_lib_pkg.sv
	make $(WORKLIB)/mem_agent_pkg.sdb
	$(VLOG) -sv $< -L uvm --include ./Seq

.PHONY : test
test : $(WORKLIB)/mem_test_lib_pkg.sdb
$(WORKLIB)/mem_test_lib_pkg.sdb : ./Test/mem_test_lib_pkg.sv
	make $(WORKLIB)/mem_sequence_lib_pkg.sdb
	make $(WORKLIB)/mem_env_pkg.sdb
	$(VLOG) -sv $< -L uvm --include ./Test

.PHONY : tb
tb : $(WORKLIB)/mem_testbench.sdb
$(WORKLIB)/mem_testbench.sdb : ./TB/mem_testbench.sv
	make $(WORKLIB)/mem_test_lib_pkg.sdb
	$(VLOG) -sv $< -L uvm

COMP_FILES := $(WORKLIB)/memory.sdb
COMP_FILES += $(WORKLIB)/mem_if.sdb
COMP_FILES += $(WORKLIB)/mem_agent_pkg.sdb
COMP_FILES += $(WORKLIB)/mem_env_pkg.sdb
COMP_FILES += $(WORKLIB)/mem_sequence_lib_pkg.sdb
COMP_FILES += $(WORKLIB)/mem_test_lib_pkg.sdb
COMP_FILES += $(WORKLIB)/mem_testbench.sdb
.PHONY : build
build : $(WORKLIB).$(TOP_MODULE)/axsim ./axsim.sh
$(WORKLIB).$(TOP_MODULE)/axsim ./axsim.sh : $(COMP_FILES)
	$(ELAB) $(TOP_MODULE) -L uvm -timescale 1ns/1ps --standalone

.PHONY : build_gui
build_gui : $(WORKLIB).$(TOP_MODULE)/xsimk
$(WORKLIB).$(TOP_MODULE)/xsimk : $(COMP_FILES)
	$(ELAB) $(TOP_MODULE) -L uvm -timescale 1ns/1ps --debug typical

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

