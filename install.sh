#!/bin/bash
################################################################################
# Setup dev env from within this repo
# Install iTerm2 before executing this installation script
################################################################################
PROJECT_NAME="dev-config"
PROJECT_FOLDER="~/Projects"
DOWNLOAD_FOLDER="~/Downloads"
################################################################################
# Install brew, git, wget for OS X
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"t
brew install git
brew install wget
################################################################################
# Backup existing Vim settings if any
if [ -e .vimrc ]; then mv .vimrc .vimrc_bak; fi
if [ -e .vim ]; then mv .vim .vim_bak; fi
################################################################################
# Set up directories
mkdir -p $PROJECT_FOLDER
mkdir -p $DOWNLOAD_FOLDER
################################################################################
# Copy configuration files
cd ~/Projects/$PROJECT_NAME
cp tmux.conf ~/.tmux.conf
cp bashrc ~/.bashrc
mkdir -p ~/.vim/colors
cp gruvbox.vim ~/.vim/colors/
cp tjkirch-yroot.zsh-theme ~/.oh-my-zsh/themes/
cp zshrc ~/.zshrc
################################################################################
# Install Vim of version 7.4 from source code
cd ~/Downloads
wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
tar jxvf vim-7.4.tar.bz2
cd vim74
./configure --with-features=huge
make && sudo make install
################################################################################
# Install oh-my-zsh, may need to mannually shell change later
# the content of install.sh is not compatible with ZSH, it must be excuted under /bin/bash
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
################################################################################
# Install Vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Install the plugins defined in vimrc
cd ~/Projects/dev-env
cp vimrc ~/.vimrc
vim +PluginInstall +qall
################################################################################
# Install tmux by compiling from source code (Install libevent as dependency firstly)
cd ~/Downloads
wget https://sourceforge.net/projects/levent/files/libevent/libevent-2.0/libevent-2.0.22-stable.tar.gz
./configure --prefix=/usr/local/
tar zxvf libevent-2.0.22-stable.tar.gz
cd libevent-2.0.22-stable/
./configure --prefix=/usr/local/
make && sudo make install  # sudo required

cd ~/Downloads
wget http://downloads.sourceforge.net/tmux/tmux-1.9a.tar.gz
tar zxvf tmux-1.9a.tar.gz
cd tmux-1.9a
LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
make && sudo make install  # sudo required
################################################################################
# Import terminal color schema for iTerm2
cd ~/Projects/$PROJECT_NAME
open gruvbox-dark.itermcolors
################################################################################
