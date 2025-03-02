# UVM_Simple_Example

Simple UVM example with [Altair (Metrics) DSim Desktop](https://www.metrics.ca/) and [Xilinx Vivado Simulator (xsim)](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools.html).

## [ Altair (Metrics) DSim](https://www.metrics.ca/)

### Batch Run (Linux)

Makefile is available for Linux batch run.

* Setup (optional)

  ```bash
  source $HOME/metrics-ca/dsim/<DSim Version>/shell_activate.bash
  export DSIM_LICENSE=$HOME/metrics-ca/dsim-license.json
  ```

  Change the path and tool version depending on your environment. Similar setup is done inside dsim.mk if this setup is not done.  

* Compile and run a test

  ```bash
  make run
  ```

  DSim is selected by dafulat. You can explicitly specify DSim by the following.

  ```bash
  make dsim_run
  ```

### Batch Run (Windows Command Prompt or PowerShell)

Besides Makefile for Linux, ./make.bat for Windows is available. You can use similar commands as Linux make.

* Setup (Optional)

  ```bat
    %LOCALAPPDATA%\metrics-ca\dsim\<DSim Version>\shell_activate.bat
    set DSIM_LICENSE=%LOCALAPPDATA%\metrics-ca\dsim-license.json
  ```

  Change the path and tool version depending on your environment. Same setup is done inside make.bat.

* Compile and run a test

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

### GUI Run (On VS Code)

  1. Open dsim_project.dpf project file in DSim Desktop extension.
  2. Click a triangle of LIBRAR CONFIGURATION pane to compile source files.
  3. Click a triangle of 'build' in SIMULATION CONFIGURATION pane.
  4. Click a triangle of 'run' in SIMULATION CONFIGURATION pane.


## [AMD (Xilinx) Vivado Simulator (xsim)](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools.html)

Change the path of XSIM in xsim.mk depending on your environment.

### Batch Run (Linux)

* Setup (Optional)

  ```bash
  source /tools/Xilinx/Vivado/<Vivado Version>/settings64.sh
  ```

  Change the path and tool version depending on your environment. Similar setup is done inside xsim.mk.

* Compile and run a test

  ```bash
  export USE_XSIM=1
  make run
  ```

  Or

  ```bash
  env USE_XSIM=1 make run
  ```

  Or


  ```bash
  make run USE_XSIM=1
  ```

  Or

  ```bash
  make xsim_run
  ```

### Launch GUI (Linux)

* Compile and run a test

  ```bash
  export USE_XSIM=1
  make gui
  ```

  Or

  ```bash
  env USE_XSIM=1 make gui
  ```

  Or

  ```bash
  make gui USE_XSIM=1
  ```

  Or

  ```bash
  make xsim_gui
  ```