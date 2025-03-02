# UVM_Simple_Example

Simple UVM example with [Altair (Metrics) DSim Desktop](https://www.metrics.ca/) and [Xilinx Vivado Simulator (xsim)](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools.html).

## [ Altair (Metrics) DSim](https://www.metrics.ca/)

### Linux (Batch Run)

* Setup (optional)

  ```bash
  source $HOME/metrics-ca/dsim/<DSim Version>/shell_activate.bash
  export DSIM_LICENSE=$HOME/metrics-ca/dsim-license.json
  ```

  Change the path and tool version depending on your environment. Similar setup is done inside dsim.mk if this setup is not done.  

* Run a test

  Makefile is available for Linux batch run.

  ```bash
  make run
  ```

  DSim is selected by dafulat. You can explicitly specify DSim by the following.

  ```bash
  make dsim_run
  ```

### Windows (Batch run)

* Setup (Optional)

  ```bat
    %LOCALAPPDATA%\metrics-ca\dsim\<DSim Version>\shell_activate.bat
    set DSIM_LICENSE=%LOCALAPPDATA%\metrics-ca\dsim-license.json
  ```

  Change the path and tool version depending on your environment. Same setup is done inside make.bat.

* Run a test (Comand Prompt)

  Besides Makefile for Linux, ./make.bat for Windows is available. You can use similar commands as Linux make.

  ```bat
  make
  ```
  or

  ```bat
  make build
  make run
  ```

* Run a test (PowerShell)

  For Windos PowerShell, `./` is necessary.

  ```bat
  ./make
  ```

  ```bat
  ./make build
  ./make run
  ```

### VS Code GUI Run (Both of Windows and Linux)

  1. Open dsim_project.dpf project file in DSim Desktop extension.
  2. Click a triangle of LIBRAR CONFIGURATION pane to compile source files.
  3. Click a triangle of 'build' in SIMULATION CONFIGURATION pane.
  4. Click a triangle of 'run' in SIMULATION CONFIGURATION pane.


## [AMD (Xilinx) Vivado Simulator (xsim)](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools.html)

### Linux

* Setup (Optional)

  ```bash
  source /tools/Xilinx/Vivado/<Vivado Version>/settings64.sh
  ```

  Change the path and tool version depending on your environment. Similar setup is done inside xsim.mk.

* Batch Run

  ```bash
  make run
  ```
  Xsim is automatically used if the Xsim setup above is done. If both of DSim and Xsim setup are done, then, DSim is selected. In that case, you can explicitly specify Xsim adding USE_XSIM=1 environment variable.

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

  Alternatively, you can add `xsim_` before the commands.

  ```bash
  make xsim_run
  ```

* GUI launch

  ```bash
  make gui
  ```