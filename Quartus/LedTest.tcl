# Copyright (C) 2017  Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License 
# Subscription Agreement, the Intel Quartus Prime License Agreement,
# the Intel FPGA IP License Agreement, or other applicable license
# agreement, including, without limitation, that your use is for
# the sole purpose of programming logic devices manufactured by
# Intel and sold by Intel or its authorized distributors.  Please
# refer to the applicable agreement for further details.

# Quartus Prime: Generate Tcl File for Project
# File: LedTest.tcl
# Generated on: Fri Feb 15 12:44:57 2019

# Load Quartus Prime Tcl Project package
package require ::quartus::project
package require ::quartus::flow

set need_to_close_project 0
set make_assignments 1



proc addVerilogFile {} {
   set myFileList {}
	set myDir ../Verilog
    if {[catch {cd $myDir} err]} {
        puts $myDir
        return
    }
    puts $myDir
	 foreach myFile [glob -nocomplain *] {
		 #进入递归后有可能修改当前的目录，
		 #因为file命令只能对当前路径有效果，
		 #所以需要保证在正确的目录下操作文件
		 cd $myDir
		 #如果文件夹是空的，则会返回空，不记录文件夹
		if {[string equal $myFile ""]} {
		  return
		} else {
			set len [string length $myFile]
			set enamestart $len-2
			set enameend  $len-1
			set ename [string range $myFile $enamestart $enameend]
			if {[string equal $ename ".v"]} {
				set fullname ""
				append fullname $myDir
				append fullname "/"
				append fullname $myFile
				#puts $fullname
				#set_global_assignment -name VERILOG_FILE  $myFile
				append myFileList $myFile
				}
		}
	}	 
	return $myFileList
}

proc helloWorld {} {
   puts "Hello, World!"
}


# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "LedTest"]} {
		puts "Project LedTest is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists LedTest]} {
		project_open -revision LedTest LedTest
	} else {
		project_new -revision LedTest LedTest
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Stratix IV"
	set_global_assignment -name DEVICE EP4SGX530HH35C2
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 17.1.0
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "12:43:49  FEBRUARY 15, 2019"
	set_global_assignment -name LAST_QUARTUS_VERSION "17.1.0 Standard Edition"
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name DEVICE_FILTER_PACKAGE FBGA
	set_global_assignment -name DEVICE_FILTER_PIN_COUNT 1152
	set_global_assignment -name DEVICE_FILTER_SPEED_GRADE 2
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
	
	#set_global_assignment -name VERILOG_FILE ../Verilog/LedTest.v
	#set_global_assignment -name TOP_LEVEL_ENTITY LedTest

	set prjDir [pwd]
	set fileList [addVerilogFile]
	cd $prjDir
	puts [pwd]
	foreach fname $fileList {
		set fnamefull "../Verilog/"
		append fnamefull $fname
		puts $fnamefull
		set_global_assignment -name VERILOG_FILE $fnamefull
	}
	

	# Commit assignments
	export_assignments
	
	#execute_flow -compile
	#execute_flow -recompile
	execute_flow  -analysis_and_elaboration

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}


