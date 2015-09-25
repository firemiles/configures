#/bin/sh

sudo apt-get -y update
sudo apt-get -y install git ipython vim zsh tmux 

# configure git
git config --global core.editor vim

# clone configure
git clone https://github.com/firemiles/configures.git ~/configure
cd ~/configure; git submodule update --init comm/zsh/z; git submodule update --init comm/vim/vim/bundle/Vundle.vim

# configure vim
ln -s /home/$USER/configure/comm/vim/vim ~/.vim
ln -s /home/$USER/configure/comm/vim/vimrc ~/.vimrc

# add powerline-font
git clone https://github.com/powerline/fonts.git /tmp/powerline-font && sh /tmp/powerline-font/install.sh

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo 'zsh' >> ~/.bashrc
ln -s /home/$USER/configure/comm/zsh/robbyrussell-firemiles.zsh-theme ~/.oh-my-zsh/themes/robbyrussell-firemiles.zsh-theme 
ln -s /home/$USER/configure/comm/zsh/z ~/.oh-my-zsh/custom/plugins/z 

# install docker
if [ $(getconf WORD_BIT) = '32' ] && [ $(getconf LONG_BIT) = '64' ] ; then # x86_64
    curl -sSL https://get.daocloud.io/docker | sh
    sudo cp /etc/fstab /etc/fstab.back && \
    (echo 'none        /sys/fs/cgroup        cgroup        defaults    0    0'| sudo tee -a /etc/fstab) || \
    sudo mv -f /etc/fstab.back /etc/fstab
else    #i686
    sudo apt-get -y install docker.io
fi 

echo 'reboot system to finish.'
