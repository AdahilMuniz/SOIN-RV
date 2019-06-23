proc load_sim {args} {
    global ROOT_DIR
    global GUI
    global RV_FILE

    set ARGS [ list "-classdebug" "-gIM_FILE=$RV_FILE" ]
    set WAVE ""

    if {$GUI == "0"} {
        lappend ARGS "-c"
    } else {
        set WAVE "$ROOT_DIR/test/wave.do"
    }

    vsim {*}$ARGS -do $WAVE tb
}