#!/bin/bash

sudo apt-get install python3 python3-dev python3-pip

sudo pip3 install ipython notebook

ipython2 kernelspec install-self
ipython3 kernelspec install-self

sudo pip3 install -r python3_package_list.txt
