proc print {args} {
	global GUI

	if {$GUI == "1"} {
		echo [ lindex $args 0 ]
	} else {
		puts [ lindex $args 0 ]
	}
}