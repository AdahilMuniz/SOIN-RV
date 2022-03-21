SOIN RV - One More Risc-V Implementation
======

<p align="center">
    <img width="200" height="200" src="resources/logo/soin_logo_bg_2700X2700.png">
</p>

<h2>Introduction</h2>

Hi! This is just a simple Risc-V implementation.

My goal with this project is to ~get rich~ learn about computer architecture implementation as well as simulation tools/process and verification techniques.

I intend to work on this project for the time necessary to learn and to get skills in the subjects that I like ~that means a lot of time~. I hope too that this project could help other students interested in this subjects.

<h2>Dependencies</h2>

* ModelSim
* Risc-V Compiler
* TCL/TK
* Python > 3

<h2>Compiling and Running</h2>

To start the compilation/simulation flow run the following command: 
 > ./build.sh

The ModelSim interface will open with a TCL/Tk GUI that may be used to select the C/Assembly program to be compiled. Using the buttons you will be able to execute each step of the flow (Compile SW, Compile the HDL and Load Simulation).

It is possible follow the flow using the TCL commands in the ModelSim transcripts. The commands are:

* **compile_sw** *[PATH TO FILE]*: It compiles the selectes software (File Path passed as argument).
* **compile_design**: It compiles the processor design.
* **compile_tb**: It compiles the testbench.
* **load_sim**: It loads the simulation for *tb* passing the compiled software path as the **IM_FILE** variables.
