#!/usr/bin/env fish

set root ~/dotfiles
set src $root/configs/.config

for dir in $src/*
    if test -d $dir
        set pkg (basename $dir)

        echo "Migrating $pkg..."

        mkdir -p $root/$pkg/.config
        mv $dir $root/$pkg/.config/
    end
end

# Remove empty directories
rmdir $root/configs/.config 2>/dev/null
rmdir $root/configs 2>/dev/null

echo "Done!"
