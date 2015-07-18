#!/bin/sh
# Provisioning script for Linux Mint Dev VMs
# For personal use only..

# --------------------------------------------------------------
# Install guake
apt-get install -y guake

# GIT config (git will be manually installed)
git config --global user.name "treystaff"
git config --global user.email "treystaff@gmail.com"

# Clone relevant repositories to /code/ dir (created before provisioning)
cd /code/
git clone https://github.com/treystaff/PhenoAnalysis.git
git clone https://github.com/treystaff/spectral_metadata_tools.git


# Python-related installs
apt-get install -y python-numpy python-scipy python-pandas python-gdal python-matplotlib ipython

# Finally, Install Pycharm
cd /tmp/
wget https://download.jetbrains.com/python/pycharm-community-4.5.3.tar.gz
tar -xzf pycharm-community-4.5.3.tar.gz
sh pycharm-community-4.5.3.tar.gz/bin/pycharm.sh
