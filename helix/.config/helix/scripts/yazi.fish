#!/usr/bin/env fish

set path $argv[1]

if test -z "$path"
    set path $PWD
end

set tmpfile (mktemp)
yazi --chooser-file "$tmpfile" "$path"
set selected (cat "$tmpfile")
rm "$tmpfile"

set rel (string replace -r "^$PWD/?" "" -- $selected)

if test -n "$rel" -a -f "$rel"
    echo $rel
else
    echo "\"\""
end
