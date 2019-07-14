#TODO: TCL script to set global variables (PATHS)
#	   Non-Project flow

##########
#SETTINGS#
##########

#Project
set design CORE

set projdir [file normalize ./../../]

set filetop $projdir/src/RV32I.sv

set incdirs [list $projdir/include $projdir/src]

#FPGA
set vendor XILINX

set partname "xc7a35tcpg236-1"

#Synthesis
set flowsynth "Vivado Synthesis 2018"
set jobsnb 2

#Vivado Variables
set vivado_prj_name "rv32i_vivado"

set outputdir ./output
set reportdir ./output/reports

######
#FLOW#
######

#Output Directory
if ![file exists $outputdir]  {file mkdir $outputdir}
#Report Directory
if ![file exists $reportdir]  {file mkdir $reportdir}

#Vivado Flow

#Project
create_project -force $vivado_prj_name $outputdir -part $partname 
#Add main file
add_files -norecurse $filetop
#Setting properties
#Add directories
set_property include_dirs $incdirs [current_fileset]
#Setting top
set_property top CORE [current_fileset]
#Updating Compile order for simulation and synthesis
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

#Launch simulation
launch_simulation

#Synthesis
synth_design -top CORE -part $partname

#Report Generation
report_utilization    -file $reportdir/utilization.rpt
report_timing_summary -file $reportdir/timing.rpt
report_io             -file $reportdir/io.xml -format xml
report_io             -file $reportdir/io.rpt
report_route_status   -file $reportdir/route.rpt

