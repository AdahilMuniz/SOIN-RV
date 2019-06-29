#!/usr/bin/wish

package require Tk

proc file_browse {args} {
    #SET
    global file_path

    set types {
        {"All Source Files"     {.S .s .c .h}    }
        {"All files"            *}
    }

    set file_path [tk_getOpenFile -filetypes $types -parent .]
}

proc bt_cmd_compile {args} {
    set file_to_compile [.ww.file_box get]
    compile_sw $file_to_compile
}

proc bt_cmd_load_sim {args} {
    load_sim
}

proc panel_run {args} {
    global SCRIPT_DIR

    #Main Window Dimensions
    set main_width 650
    set main_height 300

    #File Box Dimensions
    set fb_width 60

    #Browser Button Dimensions
    set bb_width 6
    set bb_height 1

    #General Button Dimensions
    set bt_width 15
    set bt_height 1

    #Space betwen file box and buttons box
    set fb_to_bts 70

    #Normal Logo Dimensions
    set logo_width 200
    set logo_height 188
    
    toplevel .ww -background gray

    wm title .ww "SOIN RV"
    #wm geometry . "${main_width}x${main_height}"
    .ww configure -width $main_width -height $main_height -background gray
    
    #Soin Logo
    image create photo logo         -file "$SCRIPT_DIR/tcl/gui/resources/logo/soin.png" -width $logo_width -height $logo_height
    image create photo logo_16_x_16 -file "$SCRIPT_DIR/tcl/gui/resources/logo/soin_16X16.png"
    image create photo logo_32_x_32 -file "$SCRIPT_DIR/tcl/gui/resources/logo/soin_32X32.png"

    #File Box
    entry .ww.file_box -width $fb_width -textvariable file_path 
    place .ww.file_box -x 30 -y 15 

    #Buttons
    button .ww.browser_bt -text "Browse" -width $bb_width -height $bb_height -command "file_browse"
    place .ww.browser_bt -x 550 -y 12

    button .ww.compile_sw_bt -text "Compile SW" -width $bt_width -height $bt_height -command "bt_cmd_compile"
    place .ww.compile_sw_bt -x 30 -y $fb_to_bts

    button .ww.compile_d_bt -text "Compile Design" -width $bt_width -height $bt_height -command "compile_design"
    place .ww.compile_d_bt -x 30 -y [ expr $fb_to_bts + 45 ]

    button .ww.compile_tb_bt -text "Compile TB" -width $bt_width -height $bt_height -command "compile_tb"
    place .ww.compile_tb_bt -x 200 -y [ expr $fb_to_bts + 45 ]

    button .ww.load_sim_bt -text "Load Simulation" -width $bt_width -height $bt_height -command "bt_cmd_load_sim"
    place .ww.load_sim_bt -x 200 -y $fb_to_bts 

    #Icon
    wm iconphoto . -default logo_16_x_16 logo_32_x_32

    #Logo
    label .ww.logo_label -width $logo_width -height $logo_height -background gray
    place .ww.logo_label -x 450 -y 150
    .ww.logo_label configure -image logo 

    wm withdraw .

    wm protocol .ww WM_DELETE_WINDOW {
        if {[tk_messageBox -message "Quit?" -type yesno] eq "yes"} {
           exit
        }
    }

}