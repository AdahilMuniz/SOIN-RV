proc compile_design {args} {
    global LIST_DESIGN

    set COMPILER "vlog"
    set ARGS [ list "-sv" "+acc"]

    foreach element $LIST_DESIGN {
        array set module $element

        set INCDIR_LIST [ list ]; #Include dir list with '+incdir+' string
        foreach inc $module(incdir) {
            lappend INCDIR_LIST "+incdir+$inc"
        }

        puts [ exec $COMPILER {*}$ARGS {*}$INCDIR_LIST $module(file) ]
    }
}
