#!/usr/bin/env fish

set dotfiles ~/dotfiles
set ignore .git scripts nixos

cd $dotfiles

for dir in */
    set pkg (string trim -r -c / $dir)

    if contains $pkg $ignore
        continue
    end

    set target ~/.config/$pkg

    if test -d $target; and not test -L $target
        echo "Removing existing directory: $target"
        rm -rf -- $target
    end

    echo "Restowing $pkg..."
    stow -R $pkg
end
