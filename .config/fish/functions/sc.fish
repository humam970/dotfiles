function sc
    set -l dir (fd --type d . ~/dotfiles/.config | sk)
    if test -n "$dir"
		cd $dir
        $EDITOR
    end
end
