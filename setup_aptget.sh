#!/bin/bash
sudo apt-get install vim zsh tmux
sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
sudo apt-get install --no-install-recommends libboost-all-dev
sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev
sudo apt-get install emacs openssl gcc-4.8-multilib g++-4.8-multilib
sudo apt-get install dh-autoreconf cmake
# setup mosh
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:keithw/mosh
sudo apt-get update
sudo apt-get install mosh
# install gtags
sudo apt-get install global
# prepare python packages
sudo apt-get install python-dev python2.7-dev libatlas-dev
sudo apt-get install python-pip
sudo pip install "ipython[all]"
sudo apt-get install libblas-dev liblapack-dev libatlas-base-dev gfortran
sudo apt-get update
sudo apt-get install python-networkx
sudo apt-get install ispell
pip install -U scikit-image
