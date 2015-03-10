cd ~;
git clone https://github.com/redguardtoo/emacs.d.git .emacs.d

emacs -nw --batch -l ~/.emacs.d/init.el -f package-refresh-contents

if [ "$(uname)" == "Darwin" ]; then
    # configuration for mac, not linux
    brew install w3m lua aspell emacs-clang-complete-async
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sudo apt-get install w3m lua aspell sbcl tidy xsel clang
fi

#install percol
sudo pip install percol pyflakes