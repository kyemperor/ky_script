#!/bin/bash
if [ -e youdao-dict_1.1.1-0_ubuntu_amd64.deb ]
then
break;
else
wget https://github.com/kyemperor/ky_script/raw/master/youdao-dict/youdao-dict_1.1.1-0_ubuntu_amd64.deb && echo '成功下载deb文件，准备开始安装：'
fi

echo '安装之前，请注意：
如有显示 PyQt5 (5.10.1), 卸载之..
pip3 list | grep PyQt5
pip3 uninstall pyqt5

root 用户也一样要
sudo sudo pip3 list | grep PyQt5
sudo sudo pip3 uninstall pyqt5
'

pip3 list | grep PyQt5
sudo pip3 list | grep PyQt5
echo '是否具有pyqt5? yes or no ：'
read bl
case $bl in
yes)
pip3 uninstall pyqt5
sudo pip3 uninstall pyqt5
;;
no)
break;
;;
*)
echo '输入错误！'
exit
;;
esac
sudo apt install python3

sudo apt install python3-dbus python3-lxml python3-pil python3-requests python3-xdg python3-xlib
sudo apt install python3-pyqt5 python3-pyqt5.qtmultimedia python3-pyqt5.qtquick python3-pyqt5.qtwebkit

sudo apt install gir1.2-appindicator3-0.1 qml-module-qtgraphicaleffects qml-module-qtquick-controls
sudo apt install libqt5multimedia5-plugins ttf-wqy-microhei
sudo apt install tesseract-ocr tesseract-ocr-eng tesseract-ocr-chi-sim tesseract-ocr-chi-tra

sudo apt install ubuntu-restricted-extras

sudo dpkg -i youdao-dict_1.1.1-0?ubuntu_amd64.deb && echo '恭喜！成功安装有道词典。'
