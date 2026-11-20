# Run tests with:
#   tclsh DND_test_cases.tcl

source "./DND.tcl"
proc assert condition {
    puts "------ $condition"
    if {![uplevel 1 expr $condition]} {
        return -code error "assertion failed: $condition"
    }
}


# wide span
#  midnight to end time
assert {[dnd_minutes [s2m "0800"] "2200" "0859"] == 1}
assert {[dnd_minutes [s2m "0859"] "2200" "0859"] == 1}
assert {[dnd_minutes [s2m "0000"] "2200" "0859"] == 1}
assert {[dnd_minutes [s2m "0859"] "2200" "0859"] == 1}
assert {[dnd_minutes [s2m "0900"] "2200" "0859"] == 0}
#  start time to midnight
assert {[dnd_minutes [s2m "2100"] "2200" "0859"] == 0}
assert {[dnd_minutes [s2m "2200"] "2200" "0859"] == 1}
assert {[dnd_minutes [s2m "2359"] "2200" "0859"] == 1}
assert {[dnd_minutes [s2m "2359"] "2200" "0859"] == 1}
assert {[dnd_minutes [s2m "0000"] "2200" "0859"] == 1}

#  narrow span
assert {[dnd_minutes [s2m "0800"] "0800" "0859"] == 1}
assert {[dnd_minutes [s2m "0801"] "0800" "0859"] == 1}
assert {[dnd_minutes [s2m "0859"] "0800" "0859"] == 1}
assert {[dnd_minutes [s2m "0900"] "0800" "0859"] == 0}

# edge cases around midnight

#  midnight to a minute past
assert {[dnd_minutes [s2m "2359"] "0000" "0001"] == 0} 
assert {[dnd_minutes [s2m "0000"] "0000" "0001"] == 1}
assert {[dnd_minutes [s2m "0001"] "0000" "0001"] == 1} 

puts "ALL TESTS PASSED"

# That's all!
