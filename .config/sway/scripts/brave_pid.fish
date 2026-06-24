#!/usr/bin/env fish

set pidfile /tmp/brave-origin.pid

switch "$argv[1]"
    case set
        swaymsg -t get_tree | jq '
            .. | objects
            | select(.app_id? == "brave-origin")
            | .pid
        ' > $pidfile

    case get
        if test -f $pidfile
            cat $pidfile
        else
            exit 1
        end
end
