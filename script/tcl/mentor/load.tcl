proc load_sim {args} {
    global ROOT_DIR
    global GUI
    global RV_FILE

    global THREAD_SIM_ID

    set ARGS [ list "-classdebug" "-gIM_FILE=$RV_FILE" ]
    set WAVE ""
    set CMD exec

    if {$GUI == "0"} {
        lappend ARGS "-c"
    } else {
        set WAVE "$ROOT_DIR/test/wave.do"
        set CMD eval
    }
#
    #if {$GUI == "0"} {
    #    package require Thread
#
    #    #if { [ info exists THREAD_SIM_ID] } {
    #    #    puts "Inside the IF"
    #    #    set THREAD_SIM_ACTIVE [ thread::exists $THREAD_SIM_ID ]
    #    #    puts "Thread acrtive? $THREAD_SIM_ACTIVE"
    #    #    thread::send -async $THREAD_SIM_ID [list run_simulator $CMD $WAVE $ARGS $THREAD_SIM_ACTIVE]
    #    #}
#
    #    #if { [ info exists THREAD_SIM_ID] } {
    #    #    puts "Inside the IF"
    #    #    set THREAD_SIM_ACTIVE [ thread::exists $THREAD_SIM_ID ]
    #    #    if { $THREAD_SIM_ACTIVE == "1"} {
    #    #        thread::release $THREAD_SIM_ID
    #    #    }
    #    #}
    #    
    #    set THREAD_SIM_ID [ thread::create {
    #        proc run_simulator {CMD WAVE ARGS} {
    #            $CMD vsim {*}$ARGS -do $WAVE tb
    #            return 1
    #        }
    #        thread::wait
    #    } ]
#
    #    thread::send -async $THREAD_SIM_ID [list run_simulator $CMD $WAVE $ARGS]
#
    #} else {
        #$CMD vsim {*}$ARGS -do $WAVE tb
        $CMD vsim -c
    #}
}