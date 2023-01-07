TOP_MODULE := mem_testbench
SRCS       := ../mem_testbench.sv

.PHONY: all
all: run

.PHONY: run
run : ./xsim.dir/work.mem_testbench/axsim ./axsim.sh
	./axsim.sh --testplusarg "UVM_TESTNAME=mem_test"
#	xsim $(TOP_MODULE) -R --testplusarg "UVM_TESTNAME=mem_test"

.PHONY: gui
gui : ./xsim.dir/work.mem_testbench/xsimk
	xsim $(TOP_MODULE) --gui --testplusarg "UVM_TESTNAME=mem_test" &


.PHONY : dut
dut : ./xsim.dir/work/memory.sdb
./xsim.dir/work/memory.sdb : ./DUT/memory.sv
	xvlog -sv $< -L uvm

.PHONY : agent
agent : ./xsim.dir/work/mem_if.sdb ./xsim.dir/work/mem_agent_pkg.sdb
./xsim.dir/work/mem_if.sdb : ./TB/mem_agent_pkg/mem_if.sv
	xvlog -sv $< -L uvm
./xsim.dir/work/mem_agent_pkg.sdb : ./TB/mem_agent_pkg/mem_agent.svh
./xsim.dir/work/mem_agent_pkg.sdb : ./TB/mem_agent_pkg/mem_driver.svh
./xsim.dir/work/mem_agent_pkg.sdb : ./TB/mem_agent_pkg/mem_monitor.svh
./xsim.dir/work/mem_agent_pkg.sdb : ./TB/mem_agent_pkg/mem_sequencer.svh
./xsim.dir/work/mem_agent_pkg.sdb : ./TB/mem_agent_pkg/mem_seq_item.svh
./xsim.dir/work/mem_agent_pkg.sdb : ./TB/mem_agent_pkg/mem_agent_pkg.sv
	xvlog -sv $< -L uvm --include ./TB/mem_agent_pkg

.PHONY : env
env : ./xsim.dir/work/mem_env_pkg.sdb
./xsim.dir/work/mem_env_pkg.sdb : ./xsim.dir/work/mem_agent_pkg.sdb
./xsim.dir/work/mem_env_pkg.sdb : ./TB/mem_env_pkg/mem_scoreboard.svh
./xsim.dir/work/mem_env_pkg.sdb : ./TB/mem_env_pkg/mem_env.svh
./xsim.dir/work/mem_env_pkg.sdb : ./TB/mem_env_pkg/mem_env_pkg.sv
	xvlog -sv $< -L uvm --include ./TB/mem_env_pkg

.PHONY : seq
seq : ./xsim.dir/work/mem_sequence_lib_pkg.sdb
./xsim.dir/work/mem_sequence_lib_pkg.sdb : ./xsim.dir/work/mem_agent_pkg.sdb
./xsim.dir/work/mem_sequence_lib_pkg.sdb : ./TB/mem_sequence_lib_pkg/mem_sequence_lib_pkg.sv
	xvlog -sv $< -L uvm --include ./TB/mem_sequence_lib_pkg

.PHONY : test
test : ./xsim.dir/work/mem_test_lib_pkg.sdb
./xsim.dir/work/mem_test_lib_pkg.sdb : ./xsim.dir/work/mem_sequence_lib_pkg.sdb
./xsim.dir/work/mem_test_lib_pkg.sdb : ./xsim.dir/work/mem_env_pkg.sdb
./xsim.dir/work/mem_test_lib_pkg.sdb : ./TB/mem_test_lib_pkg/mem_test_lib_pkg.sv
	xvlog -sv $< -L uvm --include ./TB/mem_test_lib_pkg

.PHONY : tb
tb : ./xsim.dir/work/mem_testbench.sdb
./xsim.dir/work/mem_testbench.sdb : ./xsim.dir/work/mem_test_lib_pkg.sdb
./xsim.dir/work/mem_testbench.sdb : ./TB/mem_testbench.sv
	xvlog -sv $< -L uvm

.PHONY : build
build : ./xsim.dir/work.mem_testbench/axsim
xsim.dir/work.mem_testbench/axsim ./axsim.sh : ./xsim.dir/work/memory.sdb
xsim.dir/work.mem_testbench/axsim ./axsim.sh : ./xsim.dir/work/mem_if.sdb
xsim.dir/work.mem_testbench/axsim ./axsim.sh : ./xsim.dir/work/mem_agent_pkg.sdb
xsim.dir/work.mem_testbench/axsim ./axsim.sh : ./xsim.dir/work/mem_env_pkg.sdb
xsim.dir/work.mem_testbench/axsim ./axsim.sh : ./xsim.dir/work/mem_sequence_lib_pkg.sdb
xsim.dir/work.mem_testbench/axsim ./axsim.sh : ./xsim.dir/work/mem_test_lib_pkg.sdb
xsim.dir/work.mem_testbench/axsim ./axsim.sh : ./xsim.dir/work/mem_testbench.sdb
	xelab $(TOP_MODULE) -L uvm -timescale 1ns/1ps --standalone

.PHONY : build_gui
build_gui : ./xsim.dir/work.mem_testbench/xsimk
xsim.dir/work.mem_testbench/xsimk : ./xsim.dir/work/memory.sdb
xsim.dir/work.mem_testbench/xsimk : ./xsim.dir/work/mem_if.sdb
xsim.dir/work.mem_testbench/xsimk : ./xsim.dir/work/mem_agent_pkg.sdb
xsim.dir/work.mem_testbench/xsimk : ./xsim.dir/work/mem_env_pkg.sdb
xsim.dir/work.mem_testbench/xsimk : ./xsim.dir/work/mem_sequence_lib_pkg.sdb
xsim.dir/work.mem_testbench/xsimk : ./xsim.dir/work/mem_test_lib_pkg.sdb
xsim.dir/work.mem_testbench/xsimk : ./xsim.dir/work/mem_testbench.sdb
	xelab $(TOP_MODULE) -L uvm -timescale 1ns/1ps --debug typical

.PHONY: clean
clean:
	rm -fr xsim.dir axsim.sh
	rm -fr *.pb
	rm -rf *.log *.jou *.str

.PHONY: distclean
distclean: clean
	rm -fr *.vcd
	rm -fr *.wdb

.PHONY : git_add
git_add :
	git add .
	git status
	git commit

.PHONY : git_push
git_push :
	git push

