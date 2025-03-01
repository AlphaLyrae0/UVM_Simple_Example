# UVM_Simple_Example

Simple UVM example with [Metrics DSim Desktop](https://www.metrics.ca/) and [Xilinx Vivado Simulator (xsim)](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools.html).

## [ Altair (Metrics) DSim](https://www.metrics.ca/)

### Batch Run

#### Linux Bash Terminal

Although, it is not necessary, doing the following setup on your bash terminal is recommended.

```bash
source $HOME/metrics-ca/dsim/<DSim Version>/shell_activate.bash
export DSIM_LICENSE=$HOME/metrics-ca/dsim-license.json
```

Change the path and tool version depending on your environment.  
Similar setup is also done inside Makefile if this setup is not done.  

To compile and run a test.

```bash
make run
 ```

DSim is automatically used if ${DSIM_HOME} is set on your bash terminal.  
Alternatively, you can explicitly specify DSim by the following.

```bash
make dsim_run
 ```

#### Windows Command Prompt

Besides Makefile for Linux, ./make.bat for Windows is available. You can use similar commands as Linux make.

```bat
make
```
or

```bat
make build
make run
```

`./` is necessary in case of Windos PowerShell.

```bat
./make
```
```bat
./make build
./make run
```

### GUI Run

  1. Open dsim_project.dpf project file in DSim Desktop extension.
  2. Click a triangle of LIBRAR CONFIGURATION pane to compile source files.
  3. Click a triangle of 'build' in SIMULATION CONFIGURATION pane.
  4. Click a triangle of 'run' in SIMULATION CONFIGURATION pane.


## [AMD (Xilinx) Vivado Simulator (xsim)](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools.html)

Change the path of XSIM in xsim.mk depending on your environment.

### Batch Run

```bash
make run USE_XSIM=1
```

Or

```bash
make xsim_run
```

### Launch GUI

```bash
make gui USE_XSIM=1
```

Or

```bash
make xsim_gui
```
