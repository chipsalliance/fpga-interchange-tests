set fp [open [lindex $argv 1] w]
read_checkpoint [lindex $argv 0]
link_design
foreach net [get_nets] {
	if {[get_nets $net] != ""} {
		if {[get_net_delays -of_objects [get_nets $net]] != ""} {
			puts $fp "$net [get_property SLOW_MAX [lindex [get_net_delays -of_objects [get_nets $net]] 0]]"
		}
	}
}
close $fp
exit