#!/bin/bash
sudo apt install -y xterm
resize -s 50 80
#terminator --geometry=485x299 -b
SELECT=$(whiptail --title "Ubuntu助手" --checklist \
"选择要安装的软件或电脑配置（可多选，空格键选择，Tab键跳转)" 50 80 35 \
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
"15" "CAJViewer" OFF \
"16" "Gnome Tweak Tool" OFF \
"17" "Sougou pinyin" OFF \
"19" "VMWare Workstation Pro 16" OFF \
"20" "CUDA 10.1, cudnn 7.6.5, (only Ubuntu 18)" OFF \
"21" "CUDA 9.1, Ubuntu18 仓库提供" OFF \
"22" "NVIDIA显卡驱动（选择此项安装CUDA中就不需选择Driver了）" OFF \
"23" "Simple Screen Recorder录屏软件" OFF \
"24" "VLC媒体播放器" OFF \
"25" "百度网盘" OFF \
"26" "RoboWare" OFF \
"==" "============================================" OFF \
"==" "============================================" OFF \
"50" "git clone设置socks5代理" OFF \
"51" "git clone取消代理" OFF \
"52" "git push记住用户名和密码（慎用）" OFF \
"53" "conda,pip设置国内源" OFF \
"54" "Ubuntu 18 再次点击图标最小化" OFF \
"55" "Ubuntu 18 取消再次点击图标最小化" OFF \
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
	echo -e "${BGreen}安装成功！${Color_Off}"
}

function keep {
	sleep 1s
}

function config_success {
	# if you want to use colored font display, must add -e parameter.
	echo -e "${BGreen}配置成功！${Color_Off}"
}

through_git_deb() {
    echo -e "${BGreen}将要安装$1 ${Color_Off}" && sleep 1s
	sudo apt install -y git

    ROOT_DIR="${HOME}/linux-assistant"
    FILE_DIR="$ROOT_DIR/$1-package"

    if [ ! -d "$ROOT_DIR" ];then
        mkdir -p $ROOT_DIR
    else
        if [ ! -d "$ROOT_DIR/$1-package" ];then
            git clone https://gitee.com/borninfreedom/$1-package.git ~/linux-assistant/$1-package
        fi
    fi

    cd $FILE_DIR
    if [ ! -f "$1.deb" ];then
        git clone https://gitee.com/borninfreedom/$1-package.git ~/linux-assistant/$1-package
    fi

    cd ~/linux-assistant/$1-package
    sudo dpkg -i $1.deb
    sudo apt -f install
    sudo apt -f install
    success
    rm -rf ~/linux-assistant/$1-package
}

through_git_sh() {
    echo -e "${BGreen}将要安装$1 ${Color_Off}" && sleep 1s
	sudo apt install -y git

    ROOT_DIR="${HOME}/linux-assistant"
    FILE_DIR="$ROOT_DIR/$1-package"

    if [ ! -d "$ROOT_DIR" ];then
        mkdir -p $ROOT_DIR
    else
        if [ ! -d "$ROOT_DIR/$1-package" ];then
            git clone https://gitee.com/borninfreedom/$1-package.git ~/linux-assistant/$1-package
        fi
    fi

    cd $FILE_DIR
    if [ ! -f "$1.sh" ];then
        git clone https://gitee.com/borninfreedom/$1-package.git ~/linux-assistant/$1-package
    fi
    
    cd ~/linux-assistant/$1-package
    chmod a+x $1.sh
    ./$1.sh
    rm -rf ~/linux-assistant/$1-package
}

through_git_appimage() {
    echo -e "${BGreen}将要安装$1 ${Color_Off}" && sleep 1s
	sudo apt install -y git

    ROOT_DIR="${HOME}/linux-assistant"
    FILE_DIR="$ROOT_DIR/$1-package"

    if [ ! -d "$ROOT_DIR" ];then
        mkdir -p $ROOT_DIR
    else
        if [ ! -d "$ROOT_DIR/$1-package" ];then
            git clone https://gitee.com/borninfreedom/$1-package.git ~/linux-assistant/$1-package
        fi
    fi

    cd $FILE_DIR
    if [ ! -f "$1.sh" ];then
        git clone https://gitee.com/borninfreedom/$1-package.git ~/linux-assistant/$1-package
    fi
    
    cd ~/linux-assistant/$1-package
    cp $1.AppImage ~/Desktop || cp $1.AppImage ~/桌面
    cd ~/Desktop || cd ~/桌面
    chmod a+x $1.AppImage
    echo -e "${BGreen}Please double click the $1.AppImage to launch it on the Desktop.${Color_Off}"
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
	echo -e "${BRed}请执行 sudo vi /etc/proxychains.conf ，将最后的 socks4 127.0.0.1 9095 改为 socks5 127.0.0.1 1089 ，其中 1089是qv2ray 6.0 版本 socks5 代理默认的开放端口，如果不确定自己的端口号，请查看后再输入。${Color_Off}"
    rm -rf ~/linux-assistant/proxychains-ng
}

function redshift {		# the former of { must have a space
	echo -e "${BGreen}Install redshift${Color_Off}" && sleep 1s \
	# -y parameter indicates that you auto select yes.
	sudo apt install -y redshift-gtk && echo -e "${BGreen}安装成功${Color_Off}"
	# when you exec a command, shell will return a flag that indicates whether exec successfully. if success ,return 0, otherwise 1 default. you can use 
	# $? to extract the flag. 
	# the role of && is  if $?==0, then exec next cmd.
	# the role of || is, if $?!=0, then exec next cmd.
}

function terminator {
	echo -e "${BGreen}将要安装terminator${Color_Off}" \
	&& sleep 1s \
	&& sudo apt install -y terminator \
	&& echo -e "${BGreen}安装成功"
}

function wps {
	echo -e "${BYellow}将要安装WPS${Color_Off}" && sleep 1s \
	&& sudo apt install -y git \
    && cd ~ \
    && git clone https://gitee.com/borninfreedom/wps-packages.git  ~/linux-assistant/wps-packages\
    && cd ~/linux-assistant/wps-packages \
    && sudo dpkg -i wps.deb \
    && sudo apt -f install \
    &&  success \
    && rm -rf wps-packages
}

function vscode {
    echo -e "${BGreen}将要安装VSCode${Color_Off}" && sleep 1s 
	sudo apt install -y git 
    cd ~ 
    git clone https://gitee.com/borninfreedom/vscode-packages.git 
    cd vscode-packages 
    sudo dpkg -i vscode.deb 
    sudo apt -f install 
    success 
    cd ~/linux-assistant 
    rm -rf vscode-packages
}

function chrome {
    echo -e "${BYellow}将要安装Google Chrome${Color_Off}" && sleep 1s 
	sudo apt install -y git 
    cd ~ 
    git clone https://gitee.com/borninfreedom/chrome-package.git ~/linux-assistant/chrome-package
    cd ~/linux-assistant/chrome-package 
    sudo dpkg -i chrome.deb 
    sudo apt -f install 
    success
    cd ~/linux-assistant
    rm -rf chrome-package
}

function mendeley {
    echo -e "${BGreen}将要安装mendeley文献管理软件${Color_Off}" && sleep 1s 
	sudo apt install -y git 
    cd ~ 
    git clone https://gitee.com/borninfreedom/mendeley-package.git ~/linux-assistant/mendeley-package
    cd ~/linux-assistant/mendeley-package 
    sudo dpkg -i mendeley.deb 
    sudo apt -f install 
    success
    rm -rf ~/linux-assistant/mendeley-package
}


function teamviewer {
    echo -e "${BYellow}将要安装TeamViewer${Color_Off}" && sleep 1s \
	&& sudo apt install -y git \
    && cd ~ \
    && git clone https://gitee.com/borninfreedom/teamviewer-package.git ~/linux-assistant/teamviewer-package\
    && cd ~/linux-assistant/teamviewer-package \
    && sudo dpkg -i teamviewer.deb \
    && sudo apt -f install \
    &&  success \
    && rm -rf teamviewer-package
}

function qq {
    echo -e "${BGreen}将要安装QQ${Color_Off}" && sleep 1s 
	sudo apt install -y git 
    cd ~ 

    FOLDER="${HOME}/linux-assistant/qq-package"
    if [ ! -d "$FOLDER" ]; then
         git clone https://gitee.com/borninfreedom/qq-package.git ~/linux-assistant/qq-package
    else
        [ ! -f "${FOLDER}/qq.deb" ] \
        && rm -rf "${FOLDER}" \
        &&  git clone https://gitlab.com/borninfreedom/qq-package.git ~/linux-assistant/qq-package
    fi

    #git clone https://gitlab.com/borninfreedom/qq-package.git ~/linux-assistant/qq-package
    cd ~/linux-assistant/qq-package 
    sudo dpkg -i qq.deb 
    sudo apt -f install 
    success 
    cd ~/linux-assistant 
    rm -rf qq-package
}


function xiangrikui {
    echo -e "${BGreen}将要安装向日葵远控${Color_Off}" && sleep 1s 
	sudo apt install -y git 
    cd ~

    FOLDER="${HOME}/linux-assistant/xiangrikui-package"
    if [ ! -d "$FOLDER" ]; then
        git clone https://gitee.com/borninfreedom/xiangrikui-package.git ~/linux-assistant/xiangrikui-package
    else
        [ ! -f "${FOLDER}/xiangrikui.deb" ] \
        && rm -rf "${FOLDER}" \
        && git clone https://gitee.com/borninfreedom/xiangrikui-package.git ~/linux-assistant/xiangrikui-package
    fi

   # git clone https://gitee.com/borninfreedom/xiangrikui-package.git ~/linux-assistant/xiangrikui-package
    cd ~/linux-assistant/xiangrikui-package 
    sudo dpkg -i xiangrikui.deb 
    sudo apt -f install 
    sudo apt -f install
    success 
    rm -rf ~/linux-assistant/xiangrikui-package
}
function pycharm-cmu {
    echo -e "${BGreen}将要安装PyCharm-Community,git代理可能会影响下载。安装包较大，请耐心等待！${Color_Off}" && sleep 1s
	sudo apt install -y git
    cd ~
    ROOT_DIR="${HOME}/linux-assistant"
    FILE_DIR="$ROOT_DIR/pycharm-cmu-packages"

    if [ ! -d "$ROOT_DIR" ];then
        mkdir -p $ROOT_DIR
    else
        if [ ! -d "$ROOT_DIR/pycharm-cmu-packages" ];then
            git clone https://gitee.com/borninfreedom/pycharm-cmu-packages.git ~/linux-assistant/pycharm-cmu-packages
        fi
    fi

    cd $FILE_DIR
    if [ ! -f "$1.deb" ];then
        git clone https://gitee.com/borninfreedom/pycharm-cmu-packages.git ~/linux-assistant/pycharm-cmu-packages
    fi

    
    cd ~/linux-assistant/pycharm-cmu-packages
    tar -zxvf pycharm.tar.gz
    cd pycharm
    cd bin
    ./pycharm.sh
    success
    rm -rf pycharm-cmu-packages
}

function qv2ray {
    echo -e "${BGreen}将要安装Qv2ray${Color_Off}" && sleep 1s
    sudo apt install -y git
    cd ~

    FOLDER="${HOME}/linux-assistant/qv2ray-packages"
    if [ ! -d "$FOLDER" ]; then
        git clone https://gitlab.com/borninfreedom/qv2ray-packages.git ~/linux-assistant/qv2ray-packages
    else
        [ ! -f "${FOLDER}/qv2ray.AppImage" ] \
        && rm -rf "${FOLDER}" \
        && git clone https://gitlab.com/borninfreedom/qv2ray-packages.git ~/linux-assistant/qv2ray-packages
    fi


    cd ~/linux-assistant/qv2ray-packages
    unzip vcore.zip -d ~/vcore

    mv ~/linux-assistant/qv2ray-packages/qv2ray-instruction.pdf ~/Desktop  || mv ~/linux-assistant/qv2ray-packages/qv2ray-instruction.pdf ~/桌面
    mv ~/linux-assistant/qv2ray-packages/qv2ray.AppImage ~
    chmod a+x ~/qv2ray.AppImage

    echo -e "${BRed}提示：请新打开一个终端，运行${Color_Off}"
    echo "sudo ./qv2ray.AppImage"
    echo -e "${BRed}在你的桌面上有一个Qv2ray的使用说明，请阅读并按照配置.${Color_Off}"
    echo -e "${BRed}关闭Qv2ray软件窗口，并运行${Color_Off}"
    echo "sudo mv ~/vcore ~/.config/qv2ray"
    echo -e "${BRed}然后运行下面指令，重新打开Qv2ray。${Color_Off}"
    echo "sudo ./qv2ray.AppImage"

    rm -rf ~/linux-assistant/qv2ray-packages
}

function virtualbox {
    sudo apt install -y virtualbox
}

hpdriver() {
    echo -e "${BGreen} HP Printer Driver will be installed${Color_Off}"
    sudo apt install -y git
    cd ~
    FOLDER="${HOME}/linux-assistant/hpdriver-package"
    if [ ! -d "$FOLDER" ]; then
        git clone https://gitee.com/borninfreedom/hpdriver-package.git ~/linux-assistant/hpdriver-package
    else
        [ ! -f "${FOLDER}/hpdriver.run" ] \
        && rm -rf "${FOLDER}" \
        && git clone https://gitee.com/borninfreedom/hpdriver-package.git ~/linux-assistant/hpdriver-package
    fi

    cd ~/linux-assistant/hpdriver-package
    chmod a+x hpdriver.run
    sudo ./hpdriver.run
    rm -rf ~/linux-assistant/hpdriver-package
}

function gitproxy {
	read -p "请输入代理socks5代理端口，默认为1089，默认代理地址是127.0.0.1：" port
    #port=${port:1089}
	while ! [[ "$port" =~ ^[0-9]+$ ]]
	do
	# -n parameter indicates that do not jump to next line
	echo -e -n "${BRed}仅接受数字："
	read port
	done

	git config --global http.proxy socks5://127.0.0.1:${port} && git config --global https.proxy socks5://127.0.0.1:${port} && config_success
}

function gitpush_store_passwd {
    echo -e "${BRed}如果您的Gitee、GitHub、Gitlab不是同用户名、同密码，使用这项会造成上传错误！${Color_Off}"
    read -r -p "确认使用吗？[y/N]" response
    if [[ "$response" =~ ^([yY][eE][sS][yY])$ ]]
    then
        git config --global credential.helper store && config_success
    else
        echo -e "${BRed}放弃配置此项${Color_Off}"
    fi

}

conda_pip_sources() {
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
    pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
    config_success
    echo -e "${BGreen}配置成功，若要修改，执行vi ~/.condarc，vi ~/.config/pip/pip.config${Color_Off}" && sleep 1s
}

gitproxy_cancel() {
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    config_success
}

selects() {
    echo $SELECT | grep "$1" && "$2"
}

vmware() {
    echo -e "${BGreen}将要安装VMWare Workstation Pro 16, 安装包较大，请耐心等待。${Color_Off}" && sleep 1s
    sudo apt install -y git
    cd ~
    FOLDER="${HOME}/linux-assistant/vmware-package"
    if [ ! -d "$FOLDER" ]; then
        git clone https://gitee.com/borninfreedom/vmware-package.git ~/linux-assistant/vmware-package
    else
        [ ! -f "${FOLDER}/vmware.bundle" ] \
        && rm -rf "${FOLDER}" \
        && git clone https://gitee.com/borninfreedom/vmware-package.git ~/linux-assistant/vmware-package
    fi

    cd ~/linux-assistant/vmware-package
    chmod a+x vmware.bundle
    sudo ./vmware.bundle
    rm -rf ~/linux-assistant/vmware-package
    echo -e "${BGreen}注册码:${Color_Off}"
    echo "1.  ZF3R0-FHED2-M80TY-8QYGC-NPKYF"
    echo "2.  YF390-0HF8P-M81RQ-2DXQE-M2UT6"
    echo "3.  ZF71R-DMX85-08DQY-8YMNC-PPHV8"

}

cuda() {
    echo -e "${BGreen}将要安装cuda10.1 update2版本${Color_Off}"
    cd
    wget http://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run
    sudo sh cuda_10.1.243_418.87.00_linux.run
    success
    echo "export PATH=$PATH:/usr/local/cuda-10.1/" >> ~/.bashrc
    echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-10.1/lib64" >> ~/.bashrc
    source ~/.bashrc
    #rm -rf ~/cuda_10.1.243_418.87.00_linux.run

    echo -e "${BGreen}将要安装cudnn7.6.5，安装包较大，请耐心等待。${Color_Off}"
    cd ~
    FOLDER="${HOME}/linux-assistant/cudnn7-package"
    if [ ! -d "$FOLDER" ]; then
        git clone https://gitee.com/borninfreedom/cudnn7-package.git ~/linux-assistant/cudnn7-package
    else
        [ ! -f "${FOLDER}/cudnn.tgz" ] \
        && rm -rf "${FOLDER}" \
        && git clone https://gitee.com/borninfreedom/cudnn7-package.git ~/linux-assistant/cudnn7-package
    fi

    cd ~/linux-assistant/cudnn7-package
    tar -xzvf cudnn.tgz
    sudo cp ~/linux-assistant/cudnn7-package/cuda/include/cudnn*.h /usr/local/cuda/include
    sudo cp ~/linux-assistant/cudnn7-package/cuda/lib64/libcudnn* /usr/local/cuda/lib64
    sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
    success
    rm -rf ~/linux-assistant/cudnn7-package
}

qv2ray_echo() {
    echo -e "${BRed}提示：请新打开一个终端，运行${Color_Off}"
    echo "sudo ./qv2ray.AppImage"
    echo -e "${BRed}在你的桌面上有一个Qv2ray的使用说明，请阅读并按照配置.${Color_Off}"
    echo -e "${BRed}关闭Qv2ray软件窗口，并运行${Color_Off}"
    echo "sudo mv ~/vcore ~/.config/qv2ray"
    echo -e "${BRed}然后运行下面指令，重新打开Qv2ray。${Color_Off}"
    echo "sudo ./qv2ray.AppImage"
}

nvidia-driver() {
    echo -e "${BGreen}将要安装NVIDIA显卡驱动${Color_Off}"
    sudo add-apt-repository ppa:graphics-drivers/ppa
    sudo apt update
    sudo ubuntu-drivers autoinstall   # for recommended
    # sudo  apt install nvidia-driver-xxx  # for self-assignment
    success
}

roboware() {
    echo -e "${BGreen}将要安装RoboWare Studio 和 RoboWare Viewer, 安装包较大，请耐心等待。${Color_Off}" && sleep 1s
    sudo apt install -y git
    cd ~
    FOLDER="${HOME}/linux-assistant/roboware-package"
    if [ ! -d "$FOLDER" ]; then
        git clone https://gitee.com/borninfreedom/roboware-package.git ~/linux-assistant/roboware-package
    else
        [ ! -f "${FOLDER}/roboware-studio*.deb" ] \
        && rm -rf "${FOLDER}" \
        && git clone https://gitee.com/borninfreedom/roboware-package.git ~/linux-assistant/roboware-package
    fi

    cd ~/linux-assistant/roboware-package
    sudo dpkg -i roboware-studio*.deb
    sudo apt -f install
    sudo apt -f install
    sudo dpkg -i roboware-viewer*.deb
    sudo apt -f install
    sudo apt -f install
    sudo mv RoboWare*.pdf ~/Desktop ||  sudo mv RoboWare*.pdf ~/桌面   
    rm -rf ~/linux-assistant/roboware-package
    echo -e "${BGreen}软件说明文档已经放到桌面。${Color_Off}"

}


#################################################################################################################
existstatus=$?

if [ $existstatus = 0 ]; then
   # echo $SELECT | grep "7" && echo "test success"
   
    echo $SELECT | grep "02" && vscode
    
    echo $SELECT | grep "04" && redshift
    echo $SELECT | grep "05" && wps
    echo $SELECT | grep "06" && terminator
    
    echo $SELECT | grep "08" && teamviewer
    echo $SELECT | grep "09" && xiangrikui
    echo $SELECT | grep "10" && qq
    echo $SELECT | grep "11" && mendeley
    echo $SELECT | grep "12" && virtualbox
    echo $SELECT | grep "13" && chrome
    echo $SELECT | grep "14" && through_git_sh miniconda
    echo $SELECT | grep "15" && through_git_appimage cajviewer
    echo $SELECT | grep "16" && sudo apt install gnome-tweak-tool

   # selects 18 hpdriver
    
 
    echo $SELECT | grep "52" && gitpush_store_passwd
    echo $SELECT | grep "53" && conda_pip_sources
    echo $SELECT | grep "54" && gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
    echo $SELECT | grep "55" && gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'previews'


    selects 51 gitproxy_cancel
    
    echo $SELECT | grep "01" && proxychains
    selects 19 vmware
    echo $SELECT | grep "17" && through_git_deb sogou && echo -e "${BGreen}please restart to make sogou available.${Color_Off}"
    echo $SELECT | grep "25" && through_git_deb baidunetdisk
    echo $SELECT | grep "07" && qv2ray
    
    selects 20 cuda
    echo $SELECT | grep "21" && sudo apt -y install nvidia-cuda-toolkit
    selects 22 nvidia-driver
    echo $SELECT | grep "23" && sudo add-apt-repository ppa:maarten-baert/simplescreenrecorder && sudo apt-get -y update && sudo apt-get -y install simplescreenrecorder
    echo $SELECT | grep "24" && sudo add-apt-repository ppa:videolan/master-daily && sudo apt-get -y update && sudo apt-get install -y vlc
    
    selects 26 roboware
    
    
    
    
    
    
    
    
    
    ##################################################
    # it's always at last. Otherwise there is a bug
    echo $SELECT | grep "03" && pycharm-cmu
    echo $SELECT | grep "50" && gitproxy
    #####################################################
    # it's the notes for some software below
    echo $SELECT | grep "19" && echo -e "${BGreen}VMWare注册码：${Color_Off}"
    echo $SELECT | grep "19" && echo "1.  ZF3R0-FHED2-M80TY-8QYGC-NPKYF"
    echo $SELECT | grep "19" && echo "2.  YF390-0HF8P-M81RQ-2DXQE-M2UT6"
    echo $SELECT | grep "19" && echo "3.  ZF71R-DMX85-08DQY-8YMNC-PPHV8"

    echo ""
    echo $SELECT | grep "17" && echo -e "${BGreen}请打开地区和语言设置->管理已安装语言->系统输入法框架，更改为fcitx，然后重启。重启后在输入法中添加搜狗，具体操作请参考：https://blog.csdn.net/lupengCSDN/article/details/80279177。只参考系统设置部分就可以，安装部分已经完成。"
    
    echo ""
    echo $SELECT | grep "07" && qv2ray_echo
    echo ""
    echo $SELECT | grep "22" && echo -e "${BGreen}请不要再更新内核，有可能导致显卡驱动失效。如果启动过程有任何问题，或者没有问题，也推荐按照此篇博客进行配置：https://blog.csdn.net/bornfree5511/article/details/109275982${Color_Off}"
    echo ""
    echo $SELECT | grep "01" && echo -e "${BRed}proxychains配置：请执行 sudo vi /etc/proxychains.conf ，将最后的 socks4 127.0.0.1 9095 改为 socks5 127.0.0.1 1089 ，其中 1089是qv2ray 6.0 版本 socks5 代理默认的开放端口，如果不确定自己的端口号，请查看后再输入。${Color_Off}"
    echo ""
    echo $SELECT | grep "26" && echo -e "${BGreen}软件说明文档已经放到桌面。${Color_Off}"


##################################################################################################################################

else
    echo "取消"
fi