#!/bin/bash

resize -s 40 80
SELECT=$(whiptail --title "Ubuntu助手" --checklist \
"选择要安装的软件或电脑配置（可多选，空格键选择，Tab键跳转)" 40 70 20 \
"01" "proxychains" OFF \
"02" "VSCode" OFF \
"03" "PyCharm Community" OFF \
"04" "RedShift-GTK" OFF \
"05" "WPS" OFF \
"06" "Terminator (Ubuntu 16不建议装，代码配色有问题)" OFF \
"07" "Qv2ray" OFF \
"08" "TeamViewer" OFF \
"09" "向日葵远控" OFF \
"10" "QQ" OFF \
"11" "mendeley文献管理软件" OFF \
"12" "VirtualBox" OFF \
"13" "Google Chrome" OFF \
"14" "Miniconda3" OFF \
"==" "============================================" OFF \
"50" "git clone 走socks5代理" OFF \
"51" "git push记住用户名和密码（慎用）" OFF \
"52" "conda,pip设置国内源" OFF \
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


function success {
	# if you want to use colored font display, must add -e parameter.
	echo -e "${BGreen}安装成功！"
}

function keep {
	sleep 1s
}

function config_success {
	# if you want to use colored font display, must add -e parameter.
	echo -e "${BGreen}配置成功！"
}

through_git_deb() {
    echo -e "${BGreen}将要安装$1 ${Color_Off}" && sleep 1s
	sudo apt install -y git
    git clone https://gitlab.com/borninfreedom/$1-package.git ~/linux-assistant/$1-package
    cd ~/linux-assistant/$1-package
    sudo dpkg -i $1.deb
    sudo apt -f install
    success
    rm -rf ~/linux-assistant/$1-package
}

through_git_sh() {
    echo -e "${BGreen}将要安装$1 ${Color_Off}" && sleep 1s
	sudo apt install -y git
    git clone https://gitlab.com/borninfreedom/$1-package.git ~/linux-assistant/$1-package
    cd ~/linux-assistant/$1-package
    chmod a+x $1.sh
    ./$1.sh
    rm -rf ~/linux-assistant/$1-package
}


function proxychains {
	echo -e "${BYellow}将要安装proxychains。${Color_Off}" && sleep 1s 
	cd ~ 
	sudo apt install -y gcc git vim cmake
	git clone https://github.com/rofl0r/proxychains-ng.git ~/linux-assistant/proxychains-ng
	cd ~/linux-assistant/proxychains-ng
	./configure
	sudo make && sudo make install
	sudo cp ./src/proxychains.conf /etc/proxychains.conf
	echo -e "${BRed}请执行 sudo vi /etc/proxychains.conf ，将最后的 socks4 127.0.0.1 9095 改为 socks5 127.0.0.1 1089 ，其中 1089是qv2ray 6.0 版本 socks5 代理默认的开放端口，如果不确定自己的端口号，请查看后再输入。"
    rm -rf proxychains-ng
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
    && git clone https://gitlab.com/borninfreedom/wps-packages.git  ~/linux-assistant/wps-packages\
    && cd ~/linux-assistant/wps-packages \
    && sudo dpkg -i wps.deb \
    && sudo apt -f install \
    &&  success \
    && rm -rf wps-packages
}

function vscode {
    echo -e "${BYellow}将要安装VSCode${Color_Off}" && sleep 1s \
	&& sudo apt install -y git \
    && cd ~ \
    && git clone https://gitlab.com/borninfreedom/vscode-packages.git \
    && cd vscode-packages \
    && sudo dpkg -i vscode.deb \
    && sudo apt -f install \
    &&  success \
    && cd ~/linux-assistant \
    && rm -rf vscode-packages
}

function chrome {
    echo -e "${BYellow}将要安装Google Chrome${Color_Off}" && sleep 1s \
	&& sudo apt install -y git \
    && cd ~ \
    && git clone https://gitlab.com/borninfreedom/chrome-package.git ~/linux-assistant/chrome-package\
    && cd ~/linux-assistant/chrome-package \
    && sudo dpkg -i chrome.deb \
    && sudo apt -f install \
    &&  success
    cd ~/linux-assistant
    rm -rf chrome-package
}

function mendeley {
    echo -e "${BGreen}将要安装mendeley文献管理软件${Color_Off}" && sleep 1s \
	&& sudo apt install -y git \
    && cd ~ \
    && git clone https://gitlab.com/borninfreedom/mendeley-package.git ~/linux-assistant/mendeley-package\
    && cd ~/linux-assistant/mendeley-package \
    && sudo dpkg -i mendeley.deb \
    && sudo apt -f install \
    &&  success \
    && rm -rf mendeley-package
}


function teamviewer {
    echo -e "${BYellow}将要安装TeamViewer${Color_Off}" && sleep 1s \
	&& sudo apt install -y git \
    && cd ~ \
    && git clone https://gitlab.com/borninfreedom/teamviewer-package.git ~/linux-assistant/teamviewer-package\
    && cd ~/linux-assistant/teamviewer-package \
    && sudo dpkg -i teamviewer.deb \
    && sudo apt -f install \
    &&  success \
    && rm -rf teamviewer-package
}

function qq {
    echo -e "${BYellow}将要安装QQ${Color_Off}" && sleep 1s \
	&& sudo apt install -y git \
    && cd ~ \
    && git clone https://gitlab.com/borninfreedom/qq-package.git ~/linux-assistant/qq-package\
    && cd ~/linux-assistant/qq-package \
    && sudo dpkg -i qq.deb \
    && sudo apt -f install \
    &&  success \
    && cd ~/linux-assistant \
    && rm -rf qq-package
}


function xiangrikui {
    echo -e "${BYellow}将要安装向日葵远控${Color_Off}" && sleep 1s \
	&& sudo apt install -y git \
    && cd ~ \
    && git clone https://gitlab.com/borninfreedom/xiangrikui-package.git ~/linux-assistant/xiangrikui-package\
    && cd ~/linux-assistant/xiangrikui-package \
    && sudo dpkg -i xiangrikui.deb \
    && sudo apt -f install \
    &&  success \
    && cd ~/linux-assistant \
    && rm -rf xiangrikui-package
}
function pycharm-cmu {
    echo -e "${BYellow}将要安装PyCharm-Community${Color_Off}" && sleep 1s \
	&& sudo apt install -y git \
    && cd ~ \
    && git clone https://gitlab.com/borninfreedom/pycharm-cmu-packages.git ~/linux-assistant/pycharm-cmu-packages\
    && cd ~/linux-assistant/pycharm-cmu-packages \
    && tar -zxvf pycharm.tar.gz \
    && cd pycharm \
    && cd bin \
    && ./pycharm.sh \
    &&  success \
    && rm -rf pycharm-cmu-packages
}

function qv2ray {
    echo -e "${BYellow}将要安装Qv2ray${Color_Off}" && sleep 1s
    sudo apt install -y git
    cd ~
    git clone https://gitlab.com/borninfreedom/qv2ray-packages.git ~/linux-assistant/qv2ray-packages
    cd ~/linux-assistant/qv2ray-packages
    unzip vcore.zip -d vcore
    mkdir -p ~/.config/qv2ray
    mv vcore ~/.config/qv2ray/
    cp qv2ray.AppImage ~/Desktop || cp qv2ray.AppImage ~/桌面
    cd ~/Desktop || cd ~/桌面
    chmod a+x qv2ray.AppImage
    sudo ./qv2ray.AppImage  
    success
}

function virtualbox {
    sudo apt install -y virtualbox
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

conda_pip_sources() {
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
    pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
    config_success
    echo -e "${BGreen}配置成功，若要修改，执行vi ~/.condarc，vi ~/.config/pip/pip.config${Color_Off}" && sleep 1s
}

existstatus=$?
if [ $existstatus = 0 ]; then
   # echo $SELECT | grep "7" && echo "test success"
   echo $SELECT | grep "01" && proxychains
   echo $SELECT | grep "02" && vscode
   echo $SELECT | grep "03" && pycharm-cmu
   echo $SELECT | grep "04" && redshift
   echo $SELECT | grep "05" && wps
   echo $SELECT | grep "06" && terminator
   echo $SELECT | grep "07" && qv2ray
   echo $SELECT | grep "08" && teamviewer
   echo $SELECT | grep "09" && xiangrikui
   echo $SELECT | grep "10" && qq
   echo $SELECT | grep "11" && mendeley
   echo $SELECT | grep "12" && virtualbox
   echo $SELECT | grep "13" && chrome
   echo $SELECT | grep "14" && through_git_sh miniconda
   echo $SELECT | grep "50" && gitproxy
   echo $SELECT | grep "51" && gitpush_store_passwd
   echo $SELECT | grep "52" && qv2ray
   echo $SELECT | grep "53" && qv2ray
   echo $SELECT | grep "54" && qv2ray
else
    echo "取消"
fi