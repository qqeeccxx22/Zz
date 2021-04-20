#!/usr/bin/env bash
cd $HOME/spider
vn =`lsb_release -rs | cut -f1 -d"."`
rm -rf $HOME/.telegram-cli
install() {
rm -rf $HOME/.telegram-cli
sudo chmod +x tg
chmod +x spider
chmod +x ts
./ts
}
if [ "$1" = "ins" ]; then
if ["$vn" == "18" ];then
echo -e "Installing depedencies for ubuntu 18  ... \n"
cd /lib/x86_64-linux-gnu/ && sudo ln -s libreadline.so.7.0 libreadline.so.6
wget "http://black-source.tk/BlackTeAM/Api/compat-libevent2-5_2.0.21-1ubuntu18_amd64-1.deb" && sudo dpkg -i compat-libevent2-5_2.0.21-1ubuntu18_amd64.deb
rm compat-libevent2-5_2.0.21-1ubuntu18_amd64.deb
fi
install
fi
chmod +x install.sh
lua start.lua
