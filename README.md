# UVM_Simple_Example

Simple UVM example with [Metrics DSim Desktop](https://www.metrics.ca/) and [Xilinx Vivado Simulator (xsim)](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools.html).

## [Metrics DSim](https://www.metrics.ca/)

Install and setup DSim Desktop on VS Code first.  
Do the following on your bash terminal.

```bash
source $HOME/metrics-ca/dsim/<DSim Version>/shell_activate.bash
export DSIM_LICENSE=$HOME/metrics-ca/dsim-license.json
```

Change the path and tool version depending on your environment.

### Batch run

```bash
 make run
 ```

DSim is automatically used if ${DSIM_HOME} is set on your bash terminal.  
Alternatively, you can explicitly specify DSim by the following.

```bash
 make dsim_run
 ```

### GUI run

  1. Open dsim_project.dpf project file in DSim Desktop extension.
  2. Click a triangle of LIBRAR CONFIGURATION pane to compile source files.
  3. Click a triangle of 'build' in SIMULATION CONFIGURATION pane.
  4. Click a triangle of 'run' in SIMULATION CONFIGURATION pane.


## [AMD (Xilinx) Vivado Simulator (xsim)](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools.html)

Change the path of XSIM in xsim.mk depending on your environment.

### Batch run

```bash
make run
```

Or

```bash
make xsim_run
```

### Launch GUI

```bash
make gui
```

Or

```bash
make xsim_gui
```
