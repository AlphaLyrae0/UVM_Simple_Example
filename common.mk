
TOP_MODULE := mem_testbench
TEST_NAME  := mem_test 

SRC_FILES += ./DUT/memory.sv
SRC_FILES += ./Agent/mem_agent_pkg.sv ./Agent/mem_if.sv
SRC_FILES += ./Env/mem_env_pkg.sv
SRC_FILES += ./Seq/mem_sequence_lib_pkg.sv
SRC_FILES += ./Test/mem_test_lib_pkg.sv
SRC_FILES += ./TB/mem_testbench.sv

INC_FILES += $(shell ls ./Agent/*.svh)
INC_FILES += $(shell ls ./Env/*.svh)
