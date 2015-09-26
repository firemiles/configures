#/bin/sh

# add repo
sudo install -y epel-release

# update repo
sudo yum -y update

# install develop tool
yum -y install git tmux

# configure git
git config --global core.editor vim

# clone configure
git clone https://github.com/firemiles/configures.git ~/configures
cd ~/configures; git submodule update --init comm/zsh/z; git submodule update --init comm/vim/vim/bundle/Vundle.vim

# install python env
yum install -y openssl-devel python-pip python-devel libffi-devel gcc ipython

# update pip
pip install --no-cache-dir --upgrade pip; 
pip install --no-cache-dir requests[security];

# install edit
yum -y install vim

# configure vim
ln -s /home/$USER/configures/comm/vim/vim ~/.vim
ln -s /home/$USER/configures/comm/vim/vimrc ~/.vimrc

# add powerline-font
while true; do
echo "Do you want to install powerline font(yes or no, default yes)?\c" 
read arg
case ${arg:=y} in 
    Y|y|YES|yes)
    git clone https://github.com/powerline/fonts.git /tmp/powerline-font && sh /tmp/powerline-font/install.sh && break;;
    N|n|NO|no)
    break;;
esac
done

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo 'zsh' >> ~/.bashrc

# configure zsh
ln -s /home/$USER/configures/comm/zsh/robbyrussell-firemiles.zsh-theme ~/.oh-my-zsh/themes/robbyrussell-firemiles.zsh-theme 
ln -s /home/$USER/configures/comm/zsh/z ~/.oh-my-zsh/custom/plugins/z 
echo 'custom theme in .zshrc'

# install docker
curl -sSL https://get.daocloud.io/docker | sh
sudo cp /etc/fstab /etc/fstab.back && \
        (echo 'none        /sys/fs/cgroup        cgroup        defaults    0    0'| sudo tee -a /etc/fstab) || \
        sudo mv -f /etc/fstab.back /etc/fstab
echo 'reboot to finish.'
