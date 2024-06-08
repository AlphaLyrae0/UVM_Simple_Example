
include common.mk

TARGET := dsim_work/$(TOP_MODULE).so
run : $(TARGET)
	dsim -uvm 1.2 -image $(TOP_MODULE) +UVM_TESTNAME=$(TEST_NAME) -waves waves.mxd
#	dsim -uvm 1.2 -image $(TOP_MODULE) +UVM_TESTNAME=$(TEST_NAME)

log :
	code dsim.log

wave :
	code waves.mxd

clean:
	rm -rf dsim_work *.env *.db *.mxd *.vcd *.log

help :
	dsim -help

build :
	make -B $(TARGET)

$(TARGET) : $(SRC_FILES) $(INC_FILES)
	dsim -uvm 1.2 -top $(TOP_MODULE) +incdir+Agent+Sequence+Env+Test+TB $(SRC_FILES) -genimage $(TOP_MODULE) +acc+b
#	dsim -uvm 1.2 -top $(TOP_MODULE) +incdir+Agent+Sequence+Env+Test+TB $(SRC_FILES) -genimage $(TOP_MODULE)
