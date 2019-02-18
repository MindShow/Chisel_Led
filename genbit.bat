
@echo off
set curPath=%~dp0
set fpgaPrj=Quartus
set  fpgaPrj=%curPath%%fpgaPrj%

REM There must be a space placed before the parenthesis (
if exist %fpgaPrj% (
        cd %fpgaPrj%
        C:\intelFPGA\17.1\quartus\bin64\quartus_sh.exe -t LedTest.tcl
        cd ..
    ) else (
        md %fpgaPrj%
    )

