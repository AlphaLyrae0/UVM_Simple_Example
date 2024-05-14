
## Auto Invoke
ifdef DSIM_HOME
  include dsim.mk
else
  include xsim.mk
endif

## Manual Invoke
dsim_% :
	make -f dsim.mk $*
xsim_% :
	make -f xsim.mk $*

.PHONY: clean git_add git_push
clean : xsim_clean dsim_clean 

git_add :
	git add .
	git status
	git commit

git_push :
	git push

