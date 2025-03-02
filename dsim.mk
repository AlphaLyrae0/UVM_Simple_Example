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

dump : ./dsim_work/dump_image.so
	$(DSIM_CMD) -uvm 1.2 -image dump_image +UVM_TESTNAME=$(TEST_NAME) -waves ./waves.mxd
log  : ./dsim.log
	code ./dsim.log
wave : ./waves.mxd
	code -n ./waves.mxd
clean:
	rm -rf dsim_work *.env *.db *.mxd *.vcd *.log
help :
	$(DSIM_CMD) -help
build :
	make -B ./dsim_work/dump_image.so

./dsim_work/dump_image.so : $(SRC_FILES) $(INC_FILES)
	$(DSIM_CMD) -uvm 1.2 -top $(TOP_MODULE) +incdir+Agent+Sequence+Env+Test+TB $(SRC_FILES) -genimage dump_image +acc+b


#------------- No Wave Dump Run -------------------------
nodump       : ./dsim_work/nodump_image.so
	$(DSIM_CMD) -uvm 1.2 -image nodump +UVM_TESTNAME=$(TEST_NAME)
nodump_build :
	make -B ./dsim_work/nodump_image.so

./dsim_work/nodump_image.so : $(SRC_FILES) $(INC_FILES)
	$(DSIM_CMD) -uvm 1.2 -top $(TOP_MODULE) +incdir+Agent+Sequence+Env+Test+TB $(SRC_FILES) -genimage nodump_image