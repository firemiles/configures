#/bin/sh

sudo apt-get -y update
sudo apt-get -y install git ipython vim zsh tmux 

git clone https://github.com/firemiles/configures.git ~/configure
cd ~/configure; git submodule update --init --recursive
ln -s /home/$USER/configure/comm/vim/vim ~/.vim
ln -s /home/$USER/configures/comm/vim/vimrc ~/.vimrc

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo 'zsh' >> ~/.bashrc
ln -s /home/$USER/configures/comm/zsh/robbyrussell-firemiles.zsh-theme ~/.oh-my-zsh/themes/robbyrussell-firemiles.zsh-theme 
ln -s /home/$USER/configures/comm/zsh/z ~/.oh-my-zsh/custom/plugins/z 

# install docker
if [ $(getconf WORD_BIT) = '32' ] && [ $(getconf LONG_BIT) = '64' ] ; then # x86_64
    curl -sSL https://get.daocloud.io/docker | sh
else    #i686
    sudo apt-get install docker.io
fi 


