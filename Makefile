
## Auto Invoke
ifdef DSIM_HOME
  include dsim.mk
else
  include xsim.mk
endif

run_% : 
	make run TEST_NAME=$*
gui_% :
	make gui TEST_NAME=$*

## Manual Invoke
dsim_% :
	make -f dsim.mk $*
xsim_% :
	make -f xsim.mk $*

clean_all : xsim_clean dsim_clean 
