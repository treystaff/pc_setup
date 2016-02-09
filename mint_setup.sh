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

# Python-related installs
apt-get install -y python-numpy python-scipy python-pandas python-gdal python-tk python-matplotlib python-pip ipython python-pip
pip install -y pytesseract
pip install -y simplekml

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

# May re-add later...Trying to mostly use Vim
## Finally, Install Pycharm
#cd /tmp/
#wget https://download.jetbrains.com/python/pycharm-community-4.5.3.tar.gz
#tar -xzf pycharm-community-4.5.3.tar.gz
## Not sure what the best place to put this is, so stick in /opt/...
#mkdir -p /opt/packages/pycharm
#cp -r /tmp/pycharm-community-4.5.3/* /opt/packages/pycharm/
#rm -rf /tmp/pycharm*
## Symlink startup to /usr/local/bin. Maybe should put installation files here too?
#ln -s /opt/packages/pycharm/bin/pycharm.sh /usr/local/bin/pycharm
## Start PyCharm
#pycharm
