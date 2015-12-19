#!/bin/bash

brew install brew-cask

# setup ruby
brew install rbenv
brew install rbenv-gem-rehash
brew install ruby-build
rbenv install 2.1.2
rbenv global 2.1.2
gem update --system
gem install bundler jekyll rails
# install node
brew install node

brew install -vd snappy leveldb gflags glog szip lmdb
brew tap homebrew/science
brew install hdf5 opencv
brew install --build-from-source --with-python -vd protobuf
brew install --build-from-source -vd boost boost-python
brew install protobuf boost
brew install emacs openssl cmake
brew install mosh
brew install macvim --override-system-vim
# install other softwares
echo Install Core Apps
brew install x2goclient
brew cask install --appdir="/Applications" alfred
brew cask install --appdir="/Applications" dropbox
brew cask install --appdir="~/Applications" iterm2
brew cask install --appdir="~/Applications" java
brew cask install --appdir="/Applications" google-chrome
brew cask --appdir="/Applications" install sublime-text3

# cleanup
echo ClearnUp of Homebrew
brew cleanup --force
rm -f -r /Library/Caches/Homebrew/*
