#/bin/sh

if [ $UID = 0 ]; then
    SUDO = ''
else
    SUDO = sudo
fi

# add repo
$SUDO install -y epel-release

# update repo
$SUDO yum -y update

# install develop tool
$SUDO yum -y install git tmux zsh

# configure git
git config --global core.editor vim

# clone configure
git clone https://github.com/firemiles/configures.git ~/configures
cd ~/configures; git submodule update --init comm/zsh/z; git submodule update --init comm/vim/vim/bundle/Vundle.vim

# install python env
$SUDO yum install -y openssl-devel python python-pip python-devel libffi-devel gcc ipython

# update pip
$SUDO pip install --no-cache-dir --upgrade pip; 
$SUDO pip install --no-cache-dir requests[security];

# install edit
$SUDO yum -y install vim

# configure vim
ln -s $HOME/configures/comm/vim/vim ~/.vim
ln -s $HOME/configures/comm/vim/vimrc ~/.vimrc

# add powerline-font
while true; do
read other
read -p "Do you want to install powerline font(yes or no, default yes)?" arg
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

# configure zsh
ln -s $HOME/configures/comm/zsh/robbyrussell-firemiles.zsh-theme ~/.oh-my-zsh/themes/robbyrussell-firemiles.zsh-theme 
ln -s $HOME/configures/comm/zsh/z ~/.oh-my-zsh/custom/plugins/z 
echo 'custom theme in .zshrc'

# install docker
curl -sSL https://get.daocloud.io/docker | sh
$SUDO cp /etc/fstab /etc/fstab.back && \
        (echo 'none        /sys/fs/cgroup        cgroup        defaults    0    0'| $SUDO tee -a /etc/fstab) || \
        $SUDO mv -f /etc/fstab.back /etc/fstab
echo 'reboot to finish.'
