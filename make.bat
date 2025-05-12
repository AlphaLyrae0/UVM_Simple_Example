@echo off

if "%DSIM_HOME%" == "" (
    echo "DSIM_HOME is not set. Setup of DSim is done automatically."
REM call "%LOCALAPPDATA%\metrics-ca\dsim\20240923.9.0\shell_activate.bat"
    call "%ProgramFiles%\Altair\DSim\2025\shell_activate.bat"
    set DSIM_LICENSE=%LOCALAPPDATA%\metrics-ca\dsim-license.json
)

set TOP_MODULE=mem_testbench
if "%2" == "" (
    set TEST_NAME=mem_test
) else (
    set TEST_NAME=%2
)

REM Define a target named 'tmp'
if "%1" == "tmp" (
    echo "Hello World (make.bat)"
    goto :EOF
)

if "%1" == "" (
    dsim -uvm 1.2 -top %TOP_MODULE% -f files.f +acc+b +UVM_TESTNAME=%TEST_NAME% -waves ./waves.mxd
    goto :EOF
)

if "%1" == "build" (
    dsim -uvm 1.2 -top %TOP_MODULE% -f files.f -genimage image +acc+b
    goto :EOF
)

if "%1" == "run" (
    dsim -uvm 1.2 -image image +UVM_TESTNAME=%TEST_NAME% -waves ./waves.mxd
    goto :EOF
)

if "%1" == "log" (
	code ./dsim.log
    goto :EOF
)

if "%1" == "wave" (
	code -n ./waves.mxd
    goto :EOF
)

if "%1" == "clean" (
    rmdir /S /Q "dsim_work"
    del /Q "*.env" "metrics.db" "*.mxd" "*.vcd" "*.log"
    goto :EOF
)

if "%1" == "help" (
    echo "Usage: make.bat [target]"
    echo "Targets:"
    echo "  tmp    - Print Hello World"
    echo "  build  - Build the application"
    echo "  run    - Run the application"
    echo "  clean  - Clean up the workspace"
)
