TOP_MODULE = mem_testbench
SRCS       = ../mem_testbench.sv

.PHONY: all
all: run

.PHONY: build
build : xsim.dir/work.mem_testbench/axsim

.PHONY: run ./axsim.sh
run : xsim.dir/work.mem_testbench/axsim
	./axsim.sh --testplusarg "UVM_TESTNAME=mem_test"
#	xsim $(TOP_MODULE) -R --testplusarg "UVM_TESTNAME=mem_test"

xsim.dir/work.mem_testbench/axsim : $(SRCS)
	xvlog -sv $(SRCS) -L uvm --include ../model --incr
	xelab $(TOP_MODULE) -L uvm -timescale 1ns/1ps --incr --standalone

.PHONY: gui
gui : xsim.dir/work.mem_testbench/xsimk
	xsim $(TOP_MODULE) --gui --testplusarg "UVM_TESTNAME=mem_test" &

xsim.dir/work.mem_testbench/xsimk : $(SRCS)
	xvlog -sv $(SRCS) -L uvm --include ../model --incr
	xelab $(TOP_MODULE) -L uvm -timescale 1ns/1ps --incr --debug typical

.PHONY: clean
clean:
	rm -fr xsim.dir axsim.sh
	rm -fr *.pb
	rm -rf *.log *.jou

.PHONY: distclean
distclean: clean
	rm -fr *.vcd
	rm -fr *.wdb
