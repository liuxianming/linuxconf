cd ~;
git clone https://github.com/redguardtoo/emacs.d.git .emacs.d

emacs -nw --batch -l ~/.emacs.d/init.el -f package-refresh-contents

sudo apt-get install w3m lua aspell sbcl tidy xsel clang pyflakes