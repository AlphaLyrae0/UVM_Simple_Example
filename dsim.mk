
include common.mk

run : dsim_work/batch.so 
	dsim -uvm 1.2 -image batch +UVM_TESTNAME=$(TEST_NAME)
dump : dsim_work/wave.so
	dsim -uvm 1.2 -image wave  +UVM_TESTNAME=$(TEST_NAME) -waves waves.mxd
compile_batch :
	make -B dsim_work/batch.so
compile_wave :
	make -B dsim_work/wave.so
view_waves :
	code waves.mxd
view_log :
	code dsim.log

clean:
	rm -rf dsim_work *.env *.db *.mxd *.vcd *.log
help :
	dsim -help

dsim_work/batch.so : $(SRC_FILES) $(INC_FILES)
	dsim -uvm 1.2 -top $(TOP_MODULE) +incdir+Agent+Sequence+Env+Test+TB $(SRC_FILES) -genimage batch
dsim_work/wave.so :  $(SRC_FILES) $(INC_FILES)
	dsim -uvm 1.2 -top $(TOP_MODULE) +incdir+Agent+Sequence+Env+Test+TB $(SRC_FILES) -genimage wave  +acc+b
