#/bin/bash

if [ $UID = 0 ]; then
    SUDO = ''
else
    SUDO = sudo
fi

$SUDO apt-get -y update
$SUDO apt-get -y install git python ipython vim zsh tmux 

# configure git
git config --global core.editor vim

# clone configure
git clone https://github.com/firemiles/configures.git ~/configures
cd ~/configures; git submodule update --init comm/zsh/z; git submodule update --init comm/vim/vim/bundle/Vundle.vim

# configure vim
ln -s $HOME/configures/comm/vim/vim ~/.vim
ln -s $HOME/configures/comm/vim/vimrc ~/.vimrc

# add powerline-font
while true; do
echo -e "Do you want to install powerline font(yes or no, default yes)?\c" 
read arg
case ${arg:=y} in 
    Y|y|YES|yes)
    rm -rf /tmp/powerline-font
    git clone https://github.com/powerline/fonts.git /tmp/powerline-font && sh /tmp/powerline-font/install.sh 
    break;;
    N|n|NO|no)
    break;;
esac
done

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo 'zsh' >> ~/.bashrc
ln -s $HOME/configures/comm/zsh/robbyrussell-firemiles.zsh-theme ~/.oh-my-zsh/themes/robbyrussell-firemiles.zsh-theme 
ln -s $HOME/configures/comm/zsh/z ~/.oh-my-zsh/custom/plugins/z 

# install docker
while true; do
echo -e "Do you want to install docker(yse or no, default yes)?\c"
read arg
case ${arg:=y} in
    Y|y|YES|yes)

    if [ $(getconf WORD_BIT) = '32' ] && [ $(getconf LONG_BIT) = '64' ] ; then # x86_64
        curl -sSL https://get.daocloud.io/docker | sh
        $SUDO cp /etc/fstab /etc/fstab.back && \
        (echo 'none        /sys/fs/cgroup        cgroup        defaults    0    0'| $SUDO tee -a /etc/fstab) || \
        $SUDO mv -f /etc/fstab.back /etc/fstab
    else    #i686
        $SUDO apt-get -y install docker.io
    fi 
    echo 'reboot system to finish.'
    break;;

    N|n|NO|no)
    break;;
esac
done
