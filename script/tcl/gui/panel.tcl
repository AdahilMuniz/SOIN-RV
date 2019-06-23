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
    set file_to_compile [.file_box get]
    compile_sw $file_to_compile
}

proc panel_run {args} {

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
    
    wm title . "SOIN RV"
    . configure -width $main_width -height $main_height
    
    #Soin Logo
    image create photo logo         -file "resources/logo/soin.png" -width $logo_width -height $logo_height
    image create photo logo_16_x_16 -file "resources/logo/soin_16X16.png"
    image create photo logo_32_x_32 -file "resources/logo/soin_32X32.png"

    #File Box
    entry .file_box -width $fb_width -textvariable file_path 
    place .file_box -x 30 -y 15 

    #Buttons
    button .browser_bt -text "Browse" -width $bb_width -height $bb_height -command "file_browse"
    place .browser_bt -x 550 -y 12

    button .compile_sw_bt -text "Compile SW" -width $bt_width -height $bt_height -command "bt_cmd_compile"
    place .compile_sw_bt -x 30 -y $fb_to_bts

    button .compile_d_bt -text "Compile Design" -width $bt_width -height $bt_height
    place .compile_d_bt -x 30 -y [ expr $fb_to_bts + 45 ]

    button .compile_tb_bt -text "Compile TB" -width $bt_width -height $bt_height
    place .compile_tb_bt -x 30 -y [ expr $fb_to_bts + 90 ]

    button .load_sim_bt -text "Load Simulation" -width $bt_width -height $bt_height
    place .load_sim_bt -x 30 -y [ expr $fb_to_bts + 130 ]

    #Icon
    wm iconphoto . -default logo_16_x_16 logo_32_x_32

    #Logo
    label .logo_label -width $logo_width -height $logo_height
    place .logo_label -x 450 -y 150
    .logo_label configure -image logo 

}