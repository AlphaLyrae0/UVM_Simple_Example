# UVM_Simple_Example

Simple UVM example with Xilinx Vivado Simulator (xsim) and Metrics DSim Desktop.

## [Metrics DSim](https://www.metrics.ca/)

Install and setup DSim Desktop on VS Code first. <BR>
Do the following on your bash terminal.

> source $HOME/metrics-ca/dsim/20240422.4.0/shell_activate.bash
export DSIM_LICENSE=$HOME/metrics-ca/dsim-license.json

Change the path and tool version depending on your environment.

### Batch run

> make run

DSim is automatically used if ${DSIM_HOME} is set on your bash terminal. <BR>
Alternatively, you can explicitly specify DSim by the following.

> make dsim_run

### GUI run

  1. Open dsim_project.dpf project file in DSim Desktop extension.
  2. Click a triangle of LIBRAR CONFIGURATION pane to compile source files.
  3. Click a triangle of 'build' in SIMULATION CONFIGURATION pane.
  4. Click a triangle of 'run' in SIMULATION CONFIGURATION pane.


## [AMD (Xilinx) Vivado Simulator](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools.html)

Change the path of XSIM in xsim.mk depending on your environment.

### Batch run

> make run

Or

> make xsim_run

### Launch GUI

> make gui

Or

> make xsim_gui
