function cdc
    set -l dir (fd --type d -d 1 . ~/code | sk)
    if test -n "$dir"
        $EDITOR $dir
    end
end
