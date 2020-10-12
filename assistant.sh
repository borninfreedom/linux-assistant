#!/bin/bash

resize -s 40 80
SELECT=$(whiptail --title "Linux助手" --checklist \
"选择要安装的软件或电脑配置（可多选，空格键选择，Tab键跳转)" 40 70 13 \
"1" "proxychains" OFF \
"2" "VSCode" OFF \
"3" "PyCharm Community" OFF \
"4" "RedShift-GTK" OFF \
"5" "WPS" OFF \
"6" "Terminator (Ubuntu 16不建议装，代码配色有问题)" OFF \
"7" "Qv2ray" OFF \
"8" "TeamViewer" OFF \
"9" "向日葵远控" OFF \
"10" "QQ" OFF \
"" "============================================" OFF \
"50" "git clone 走socks5代理" OFF \
"51" "git push记住用户名和密码（慎用）" OFF \
3>&1 1>&2 2>&3
)


Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White



function keep {
	sleep 1s
}

function success {
	# if you want to use colored font display, must add -e parameter.
	echo -e "${BGreen}安装成功！"
}

function config_success {
	# if you want to use colored font display, must add -e parameter.
	echo -e "${BGreen}配置成功！"
}

function proxychains {
	echo -e "${BYellow}将要安装proxychains。${Color_Off}" && sleep 1s 
	cd ~ 
	sudo apt install -y gcc git vim cmake
	git clone https://github.com/rofl0r/proxychains-ng.git
	cd ~/proxychains-ng
	./configure
	sudo make && sudo make install
	sudo cp ./src/proxychains.conf /etc/proxychains.conf
	echo -e "${BRed}请执行 sudo vi /etc/proxychains.conf ，将最后的 socks4 127.0.0.1 9095 改为 socks5 127.0.0.1 1089 ，其中 1089是qv2ray 6.0 版本 socks5 代理默认的开放端口，如果不确定自己的端口号，请查看后再输入。"
}

function redshift {		# the former of { must have a space
	echo "Install redshift" && sleep 1s \
	# -y parameter indicates that you auto select yes.
	sudo apt install -y redshift-gtk && echo "${BYellow}安装成功"
	# when you exec a command, shell will return a flag that indicates whether exec successfully. if success ,return 0, otherwise 1 default. you can use 
	# $? to extract the flag. 
	# the role of && is  if $?==0, then exec next cmd.
	# the role of || is, if $?!=0, then exec next cmd.
}

function terminator {
	echo -e "${BYellow}将要安装terminator${Color_Off}" \
	&& sleep 1s \
	&& sudo apt install -y terminator \
	&& echo -e "${BYellow}安装成功"
}

function wps {
	echo -e "${BYellow}将要安装WPS${Color_Off}" && sleep 1s \
	&& sudo apt install -y git \
    && cd ~ \
    && git clone https://gitlab.com/borninfreedom/wps-packages.git \
    && cd wps-packages \
    && sudo dpkg -i wps.deb \
    && sudo apt -f install \
    &&  success
}

function vscode {
    echo -e "${BYellow}将要安装VSCode${Color_Off}" && sleep 1s \
	&& sudo apt install -y git \
    && cd ~ \
    && git clone https://gitlab.com/borninfreedom/vscode-packages.git \
    && cd vscode-packages \
    && sudo dpkg -i vscode.deb \
    && sudo apt -f install \
    &&  success
}

function teamviewer {
    echo -e "${BYellow}将要安装TeamViewer${Color_Off}" && sleep 1s \
	&& sudo apt install -y git \
    && cd ~ \
    && git clone https://gitlab.com/borninfreedom/teamviewer-package.git \
    && cd teamviewer-package \
    && sudo dpkg -i teamviewer.deb \
    && sudo apt -f install \
    &&  success
}

function qq {
    echo -e "${BYellow}将要安装QQ${Color_Off}" && sleep 1s \
	&& sudo apt install -y git \
    && cd ~ \
    && git clone https://gitlab.com/borninfreedom/qq-package.git \
    && cd qq-package \
    && sudo dpkg -i qq.deb \
    && sudo apt -f install \
    &&  success
}


function xiangrikui {
    echo -e "${BYellow}将要安装向日葵远控${Color_Off}" && sleep 1s \
	&& sudo apt install -y git \
    && cd ~ \
    && git clone https://gitlab.com/borninfreedom/xiangrikui-package.git \
    && cd xiangrikui-package \
    && sudo dpkg -i xiangrikui.deb \
    && sudo apt -f install \
    &&  success
}
function pycharm-cmu {
    echo -e "${BYellow}将要安装PyCharm-Community${Color_Off}" && sleep 1s \
	&& sudo apt install -y git \
    && cd ~ \
    && git clone https://gitlab.com/borninfreedom/pycharm-cmu-packages.git \
    && cd pycharm-cmu-packages \
    && tar -zxvf pycharm.tar.gz \
    && cd pycharm \
    && cd bin \
    && ./pycharm.sh \
    &&  success
}

function qv2ray {
    echo -e "${BYellow}将要安装Qv2ray${Color_Off}" && sleep 1s
    sudo apt install -y git
    cd ~
    git clone https://gitlab.com/borninfreedom/qv2ray-packages.git
    cd qv2ray-packages
    unzip vcore.zip
    chmod a+x qv2ray.AppImage
    sudo ./qv2ray.AppImage
    mv vcore ~/.config/qv2ray/
    success
}


function gitproxy {
	read -p "请输入代理socks5代理端口，默认为1089，默认代理地址是127.0.0.1：" port
    port=${port:1089}
	while ! [[ "$port" =~ ^[0-9]+$ ]]
	do
	# -n parameter indicates that do not jump to next line
	echo -e -n "${BRed}仅接受数字："
	read port
	done

	git config --global http.proxy socks5://127.0.0.1:${port} && git config --global https.proxy socks5://127.0.0.1:${port} && config_success
}

function gitpush_store_passwd {
	git config --global credential.helper store && config_success
}



existstatus=$?
if [ $existstatus = 0 ]; then
   # echo $SELECT | grep "7" && echo "test success"
   echo $SELECT | grep "1" && proxychains
   echo $SELECT | grep "2" && vscode
   echo $SELECT | grep "3" && pycharm-cmu
   echo $SELECT | grep "4" && redshift
   echo $SELECT | grep "5" && wps
   echo $SELECT | grep "6" && terminator
   echo $SELECT | grep "7" && qv2ray
   echo $SELECT | grep "8" && teamviewer
   echo $SELECT | grep "9" && xiangrikui
   echo $SELECT | grep "10" && qq
   echo $SELECT | grep "50" && gitproxy
   echo $SELECT | grep "51" && gitpush_store_passwd
   echo $SELECT | grep "52" && qv2ray
   echo $SELECT | grep "53" && qv2ray
   echo $SELECT | grep "54" && qv2ray
else
    echo "取消"
fi