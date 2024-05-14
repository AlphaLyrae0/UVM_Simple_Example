# UVM_Simple_Example

Simple UVM example with Xilinx Vivado Simulator (xsim) and Metrics DSim Desktop.

## [AMD (Xilinx) Vivado Simulator](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools.html)

  To run a test with xsim

> make run_mem_test

or simply

> make run

on it

## [Metrics DSim](https://www.metrics.ca/)

To run a test with Dsim

Install and setup Dsim Desktop on VS Code first

* ### GUI run for both of Windows and Linux

  1. Open dsim_project.dpf project file in DSim Desktop extension.
  2. Click a triangle of LIBRAR CONFIGURATION pane to compile source files.
  3. Click a triangle of 'all' in SIMULATION CONFIGURATION pane.

* ### Batch run for Linux only

  1. Add a new DSim Desktop terminal on VS Code.
  2. Hit
      > make run_mem_test

      or simply

      > make run

      on it

