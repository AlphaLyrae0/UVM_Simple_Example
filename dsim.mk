
include common.mk

run : dump
#run : nodump

TARGET := dsim_work/$(TOP_MODULE).so
dump : $(TARGET)
	dsim -uvm 1.2 -image $(TOP_MODULE) +UVM_TESTNAME=$(TEST_NAME) -waves ./waves.mxd

log :
	code dsim.log

wave : ./waves.mxd
	code ./waves.mxd

clean:
	rm -rf dsim_work *.env *.db *.mxd *.vcd *.log

help :
	dsim -help

build :
	make -B $(TARGET)

$(TARGET) : $(SRC_FILES) $(INC_FILES)
	dsim -uvm 1.2 -top $(TOP_MODULE) +incdir+Agent+Sequence+Env+Test+TB $(SRC_FILES) -genimage $(TOP_MODULE) +acc+b



#------------- No Wave Dump Run -------------------------
TARGET_NODUMP := dsim_work/$(TOP_MODULE)_nodump.so
nodump : $(TARGET_NODUMP)
	dsim -uvm 1.2 -image $(TOP_MODULE)_nodump +UVM_TESTNAME=$(TEST_NAME)

build_nodump :
	make -B $(TARGET_NODUMP)

$(TARGET_NODUMP) : $(SRC_FILES) $(INC_FILES)
	dsim -uvm 1.2 -top $(TOP_MODULE) +incdir+Agent+Sequence+Env+Test+TB $(SRC_FILES) -genimage $(TOP_MODULE)_nodump