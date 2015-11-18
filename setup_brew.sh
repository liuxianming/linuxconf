#!/bin/bash

brew install -vd snappy leveldb gflags glog szip lmdb
brew tap homebrew/science
brew install hdf5 opencv
brew install --build-from-source --with-python -vd protobuf
brew install --build-from-source -vd boost boost-python
brew install protobuf boost
brew install emacs openssl cmake
brew install mosh
