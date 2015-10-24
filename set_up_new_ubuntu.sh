sudo apt-get update
sudo apt-get install openssh

sudo apt-get install python-pip
# setup python
sudo pip install percol pyflakes

# install emacs, git
sudo apt-get install emacs git
git config --global user.name "liuxianming"
git config --global user.email "liuxianming@gmail.com"

git clone git@github.com:liuxianming/linuxconf.git
cd linuxconf
# setup bash
cd bash
cp .bashrc ~/.bashrc
cp .profile ~/.profile
cp .bashrc ~/.bash_profile

cd ../vim
ln -s .vim ~/.vim
ln -s .vimrc ~/

cd ../emacs
cp -rf ./emacs.d ~/.emacs.d
emacs -nw --batch -l ~/.emacs.d/init.el -f package-refresh-contents

# setup on-my-zsh
sudo apt-get istall zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
chsh -s /bin/zsh

cd ../zsh
cp .zshrc ~/

# install htop
sudo apt-get install htop lrzsz

sudo apt-get install libboost-all-dev
sudo apt-get install gcc-4.8-multilib g++-4.8-multilib

sudo apt-get install libgtest-dev
sudo apt-get install cmake

sudo apt-get install dh-autoreconf

# protobuf
git clone git@github.com:google/protobuf.git
cd protobuf
./autogen.sh
./configure
make
make check
make install


