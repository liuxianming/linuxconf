#!/bin/bash

sudo apt-get install build-essential

sudo apt-get build-dep emacs24

cd ~/Downloads && wget -c http://ftp.gnu.org/gnu/emacs/emacs-24.5.tar.gz
cd ~/Downloads && tar -xf emacs-24.5.tar.* && cd emacs-24.5
./configure

make -j 4

sudo make install 
