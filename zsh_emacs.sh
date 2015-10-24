# Installing Zsh + YADR/prezto

# for linux:
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
sudo pip install --upgrade rope
sudo pip install --upgrade epc jedi
sudo pip install --upgrade flake8
sudo pip install --upgrade importmagic
sudo pip install --upgrade percol pyflakes autopep8
sudo pip install --upgrade virtualenv

# color theme
git clone https://github.com/sellout/emacs-color-theme-solarized.git ~/.emacs.d/site-lisp/emacs-color-theme-solarized

# setting up cpplint.py
wget http://google-styleguide.googlecode.com/svn/trunk/cpplint/cpplint.py
sudo mv cpplint.py /usr/local/bin/cpplint.py
sudo chmod 755 /usr/local/bin/cpplint.py

# run emacs to complete configuration
# git clone https://github.com/gabrielelanaro/emacs-for-python.git .emacs.d/site-lisp/emacs-for-python
emacs -nw
