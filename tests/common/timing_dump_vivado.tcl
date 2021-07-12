set fp [open [lindex $argv 1] w]
read_checkpoint [lindex $argv 0]
link_design
foreach net [get_nets] {
	if {[get_nets $net] != ""} {
		foreach delay [get_net_delays -interconnect_only -of_objects [get_nets $net]] {
			puts $fp "[get_property name $delay] [get_property SLOW_MAX $delay]"
		}
	}
}
close $fp
exit
