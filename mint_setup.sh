#!/bin/sh
# Provisioning script for Linux Mint Dev VMs
# For personal use only..

# --------------------------------------------------------------
# Check if installation on SSD drive
read -p "Is installation on an SSD?" yn
case $yn in
    [Yy]* )
        # Below configuration suggested by community.linuxmint.com/tutorial/view/293
        tune2fs -i 7d
        tune2fs -c 15
        echo vm.swappiness=10 >> /etc/sysctl.conf
        break;;
    [Nn]* ) break;;
    * ) echo "Please Answer y/n"; break;; esac

read -p "Is installation on an SSD?"

# Install guake (obsolete if we are installing i3....)
#apt-get install -y guake

# WRITE LATEX. LOVE LATEX. SURRENDER.
apt-get install texmaker texlive

# Install the i3 window manager
apt-get install -y i3 i3status dmenu

# Install vim!
apt-get install -y vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install feh (for background stuff...)
apt-get install -y feh

# Install scrot for screen capture
apt-get install -y scrot

# Install the xautolock utility for screen locking in X
apt-get install -y xautolock

# Imagemagick is useful for PIL
apt-get install -y imagemagick

# Install QGIS
apt-get install -y qgis qgis-python

# GIT config (git will be manually installed)
git config --global user.name "treystaff"
git config --global user.email "treystaff@gmail.com"

# Git i3 blocks (keep repo in opt for now...
apt-get install -y ruby-ronn acpi
cd /opt/
git clone git://github.com/vivien/i3blocks
cd i3blocks
make clean all
make install

# Clone relevant repositories to /code/ dir (created before provisioning)
cd /code/
git clone https://github.com/treystaff/PhenoAnalysis.git
git clone https://github.com/treystaff/spectral_metadata_tools.git

# Install cmake
apt-get install build-essential cmake

# Python-related installs
apt-get install python-dev
apt-get install -y python-numpy python-scipy python-pandas python-gdal python-tk python-matplotlib python-pip ipython python-pip
pip install -y pytesseract
pip install -y simplekml

# Install powerline status bar (fonts install useful for vim-airline
# pip install --user git+git://github.com/powerline/powerline
cd /tmp/
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir ~/.fonts/
mv PowerlineSymbols.otf ~/.fonts/
fc-cache -f -v
mkdir -p ~/.config/fontconfig/fonts.conf
mv 10-powerline-symbols.conf ~/.config/fontconfig/fonts.conf/

# Now link dotfiles to the appropriate places. 
# (Maybe move this bit into its own script later)
# First move old files to a holding location
mkdir ~/.old_dotfiles
dotfiles="bashrc gitconfig vimrc xmodmap i3/config i3/i3blocks.conf"
for dotfile in $dotfiles; do
	if [ -f ~/.$dotfile ]
	then
		mv ~/.$dotfile ~/.old_dotfiles
	fi
	# For now, assume dir is /code/pc_setup/dotfiles.
	ln -s /code/pc_setup/dotfiles/$dotfile ~/.$dotfile 
done

# Install vim plugins
vim +PluginInstall +qall

# Install/configure the YouCompleteMe vim plugin
# (install node stuff for enabling js complete)
apt-get install nodejs nodejs-dev 
ln -s /usr/bin/nodejs /usr/bin/node
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer --tern-completer

# Install flake8 for python syntax checking
apt-get install python-flake8

# Install exuberant-ctags (tagging of source code. Makes nav easier in vim)
apt-get install exuberant-ctags

# Get and install the taglist plugin for vim (utilizes exuberant-ctags)
cd /tmp/
wget http://www.vim.org/scripts/download_script.php?src_id=19574 -O taglist.zip
unzip taglist.zip -d ~/.vim/
vim "+helptags ~/.vim/doc/" +qall
