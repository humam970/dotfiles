#!/usr/bin/env fish

set dotfiles ~/dotfiles
set ignore .git scripts

cd $dotfiles

for dir in */
    set pkg (string trim -r -c / $dir)

    if contains $pkg $ignore
        continue
    end

    echo "Restowing $pkg..."
    stow -R $pkg
end
