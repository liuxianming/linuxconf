#!/bin/bash
if [ "$(uname)" == "Darwin" ]; then
  # install homebrew
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
  cmd=brew
  # python on mac need to be reinstalled
  brew install python
else
  cmd=sudo apt-get
  sudo apt-get update
  sudo apt-get install python-pip
fi

# first set up git and download config
${cmd} install git
git config --global user.name "liuxianming"
git config --global user.email "liuxianming@gmail.com"
if ! [[ -d $HOME/linuxconf ]]; then
  git clone https://github.com/liuxianming/linuxconf.git $HOME/linuxconf
fi
cd $HOME/linuxconf

# setup python
sudo pip install -r $HOME/linuxconf/python_package_list.txt
# setup all packages using apt-get / brew
cd $HOME/linuxconf
if [ "$(uname)" == "Darwin" ]; then
  chmod +x ./setup_brew.sh
  ./setup_brew.sh
else
  chmod +x ./setup_aptget.sh
  ./setup_aptget.sh
fi

# protobuf
echo Installing Protobuf
git clone https://github.com/google/protobuf.git $HOME/protobuf
cd $HOME/protobuf
./autogen.sh
./configure
make
make check
sudo make install

cd $HOME/linuxconf
# Installing Zsh + YADR/prezto
if [ "$(uname)" == "Darwin" ]; then
  sh -c "`curl -fsSL https://raw.github.com/skwp/dotfiles/master/install.sh`"
else
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  export PATH=$PATH:$HOME/.rbenv/bin
  rbenv install 2.0.0-p353
  eval "$(rbenv init -)"
  rbenv shell 2.0.0-p353
  sh -c "`curl -fsSL https://raw.github.com/skwp/dotfiles/master/install.sh`"
fi
# copy the tmux configuration
cp ./tmux.conf ~/.tmux.conf

# Configure emacs
cp -rf ./emacs/emacs.d ~/.emacs.d
# color theme
git clone https://github.com/sellout/emacs-color-theme-solarized.git ~/.emacs.d/site-lisp/emacs-color-theme-solarized
# setting up cpplint.py
wget http://google-styleguide.googlecode.com/svn/trunk/cpplint/cpplint.py
sudo mv cpplint.py /usr/local/bin/cpplint.py
sudo chmod 755 /usr/local/bin/cpplint.py
emacs -nw
# copy emacsclient.py
sudo cp emacs/emacsclient-tcpip /usr/local/bin/
sudo chmod +x /usr/local/bin/emamcsclient-tcpip

# Install docker
echo "Installing Docker..."
if [ "$(uname)" == "Darwin" ]; then
  brew install Caskroom/cask/dockertoolbox
else
  sudo wget -qO- https://get.docker.com/ | sh
fi

# copy other config files
if ! [[ -d ~/.ssh/ ]]; then
  mkdir ~/.ssh/
fi
cp ./ssh/config ~/.ssh/
cp ./zsh/.zshrc ~/
