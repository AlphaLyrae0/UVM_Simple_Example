ifdef DSIM_HOME
  DSIM_CMD  := dsim 
else
  DSIM_DIR  := ${HOME}/metrics-ca/dsim
 #DSIM_DIR  := ${HOME}/AltairDSim
  DSIM_HOME := $(shell ls -t1d $(DSIM_DIR)/* | head -n 1)
  DSIM_SCR  := $(DSIM_HOME)/shell_activate.bash
  DSIM_CMD  := $(DSIM_SCR); dsim 
 #export DSIM_LICENSE := $(DSIM_DIR)/dsim-license.json
  export DSIM_LICENSE := ${HOME}/metrics-ca/dsim/dsim-license.json
endif

run : dump
#run : nodump

TARGET := dsim_work/$(TOP_MODULE).so
dump : $(TARGET)
	$(DSIM_CMD) -uvm 1.2 -image $(TOP_MODULE) +UVM_TESTNAME=$(TEST_NAME) -waves ./waves.mxd
log : ./dsim.log
	code ./dsim.log
wave : ./waves.mxd
	code -n ./waves.mxd
clean:
	rm -rf dsim_work *.env *.db *.mxd *.vcd *.log
help :
	$(DSIM_CMD) -help
build :
	make -B $(TARGET)

$(TARGET) : $(SRC_FILES) $(INC_FILES)
	$(DSIM_CMD) -uvm 1.2 -top $(TOP_MODULE) +incdir+Agent+Sequence+Env+Test+TB $(SRC_FILES) -genimage $(TOP_MODULE) +acc+b


#------------- No Wave Dump Run -------------------------
TARGET_NODUMP := dsim_work/$(TOP_MODULE)_nodump.so
nodump : $(TARGET_NODUMP)
	$(DSIM_CMD) -uvm 1.2 -image $(TOP_MODULE)_nodump +UVM_TESTNAME=$(TEST_NAME)
build_nodump :
	make -B $(TARGET_NODUMP)

$(TARGET_NODUMP) : $(SRC_FILES) $(INC_FILES)
	$(DSIM_CMD) -uvm 1.2 -top $(TOP_MODULE) +incdir+Agent+Sequence+Env+Test+TB $(SRC_FILES) -genimage $(TOP_MODULE)_nodump