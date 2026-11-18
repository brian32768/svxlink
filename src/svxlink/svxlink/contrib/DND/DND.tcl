# DND = "Do not disturb"
#
# "dnd" is a function that
# checks current time against "do not disturb" start and end settings,
# "start" should be in the evening like "2200"
# and "end" should be in the morning, like "0800"
#
# return 1 if we're in the DND time span
# return 0 if we're not
# If either "start" or "end" is set to -1 then return 0
#

# If a string starts with a zero, tcl normally assumes it's octal
# this function forces it to be treated as a decimal integer instead.
# Source - https:#stackoverflow.com/a/2111822
# Posted by glenn jackman
# Retrieved 2026-11-07, License - CC BY-SA 2.5
#
proc forceInteger { x } {
    set count [scan $x %d%s n rest]
    if { $count <= 0 || ( $count == 2 && ![string is space $rest] ) } {
        return -code error "not an integer: \"$x\""
    }
    return $n
}

proc dnd {start end} {

    if {$start<0 || $end<0} {
	#puts "DND settings not enabled."
	return 1
    }

    # Get the current time in minutes.
    set now [clock seconds]
    set hour [clock format $now -format "%k"]
    regexp {([1-5]?\d)$} [clock format $now -format "%M"] -> minute
    set now_minutes [expr {$hour * 60 + $minute}]

    # Convert the start time to minutes
    set start_hour   [forceInteger [string range $start 0 1]]
    set start_minute [forceInteger [string range $start 2 3]]
    set start_minutes [expr {$start_hour * 60 + $start_minute}]

    # Convert the end time to minutes
    set end_hour   [forceInteger [string range $end 0 1]]
    set end_minute [forceInteger [string range $end 2 3]]
    set end_minutes [expr {$end_hour * 60 + $end_minute}]

    if {($now_minutes >= $start_minutes) || ($now_minutes < $end_minutes)} {
	return 1
    }

    return 0
}

# That's all!
