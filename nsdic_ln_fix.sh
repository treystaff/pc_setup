dotfiles="bashrc gitconfig vimrc xmodmap i3/config i3/i3blocks.conf"
for dotfile in $dotfiles; do
        if [ -f ~/.$dotfile ]
        then
                mv ~/.$dotfile ~/.old_dotfiles
        fi
        # For now, assume dir is /code/pc_setup/dotfiles.
        ln -s /home/trst2284/code/pc_setup/dotfiles/$dotfile ~/.$dotfile
done
