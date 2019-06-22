proc load_sim {args} {
    global FILE
    global ROOT_DIR
    global GUI

    set ARGS [ list "-classdebug" "-gIM_FILE=$FILE" ]
    set WAVE ""

    if {$GUI == "0"} {
        lappend ARGS "-c"
    } else {
        set WAVE "$ROOT_DIR/test/wave.do"
    }

    vsim {*}$ARGS -do $WAVE tb
}