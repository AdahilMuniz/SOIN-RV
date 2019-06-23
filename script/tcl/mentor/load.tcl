proc load_sim {args} {
    global FILE_TO_LOAD
    global ROOT_DIR
    global GUI

    set ARGS [ list "-classdebug" "-gIM_FILE=$FILE_TO_LOAD" ]
    set WAVE ""

    if {$GUI == "0"} {
        lappend ARGS "-c"
    } else {
        set WAVE "$ROOT_DIR/test/wave.do"
    }

    vsim {*}$ARGS -do $WAVE tb
}