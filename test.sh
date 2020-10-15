#!/bin/bash

through_git() {
#    echo -e "${BYellow}将要安装$1 ${Color_Off}" && sleep 1s
#    sudo apt install -y git
#    git clone https://gitlab.com/borninfreedom/$1-package.git ~/linux-assistant/$1-package
#    cd ~/linux-assistant/$1-package
#    sudo dpkg -i $1.deb
#    sudo apt -f install
    rm -rf ~/linux-assistant/$1-package
}

through_git mendeley