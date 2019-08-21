#!/bin/bash
echo -e "
安装宝塔面板,宝塔Linux面板命令大全：https://www.bt.cn/btcode.html。

输入选项，以安装对应系统的宝塔面板：
c. 为cenos7.1+、Fedora 安装Linux面板6.9.7 。
u. 为Ubuntu16.04+、Debian9.0+ 安装Linux面板6.9.7。
r. 重启面板。
update. Linux面板6.9.7升级。
other. 备用节点。
q. 退出。
"
read t
case $t in
c)
wget -O bt_install.sh http://download.bt.cn/install/install_6.0.sh && sudo bash bt_install.sh $$ echo "安装成功！"
;;
u)
wget -O bt_install.sh http://download.bt.cn/install/install-ubuntu_6.0.sh && sudo bash bt_install.sh $$ echo "安装成功！"
;;
r)
bt restart && echo "重启面板成功。"
;;
update)
curl http://download.bt.cn/install/update6.sh|bash && echo "升级完成！"
;;
other)
echo -e "备用节点：

备用节点【广东】：
yum install -y wget && wget -O install.sh http://125.88.182.172:5880/install/install_6.0.sh && sh install.sh

备用节点【香港】：
yum install -y wget && wget -O install.sh http://103.224.251.67:5880/install/install_6.0.sh && sh install.sh

备用节点【美国】：
yum install -y wget && wget -O install.sh http://128.1.164.196:5880/install/install_6.0.sh && sh install.sh
"
;;
q)
exit
;;
*)
echo "输入错误。"
;;
esac


