if [ "$(uname)" == "Darwin" ]; then
  # install homebrew
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
  cmd=brew
  # python on mac need to be reinstalled
  brew install python
else:
  cmd=sudo apt-get
  sudo apt-get update
  sudo apt-get install python-pip
fi

# first set up git and download config
${cmd} install git
git config --global user.name "liuxianming"
git config --global user.email "liuxianming@gmail.com"
git clone git@github.com:liuxianming/linuxconf.git $HOME/unixconf
cd $HOME/unixconf

# setup python
sudo pip install -r python_package_list.txt
# setup all packages using apt-get / brew
${cmd} install < ./sys_package_list.txt

# protobuf
git clone git@github.com:google/protobuf.git protobuf
cd $HOME/protobuf
./autogen.sh
./configure
make
make check
sudo make install

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