#!/bin/bash
while true
do
echo -e "
请选择您需要的功能：
1.安装v2ray。
2.安装bbr。
3.安装南浪琴版暴力魔改BBR，仅centos可用。
4.使用systemctl启动v2ray。
5.使用systemctl停止v2ray。
6.使用systemctl重启v2ray。
7.指定config文件，然后重启v2ray。
8.写入新的config文件到当前目录下。
bbr.测试BBR是否成功安装。
q.退出。

请输入您的选择："
read choice
case $choice in
1)
sudo wget https://install.direct/go.sh && sudo chmod a+x ./go.sh && sudo bash ./go.sh && echo -e "\成功安装v2ray！" && echo -e "
此脚本会自动安装以下文件：

/usr/bin/v2ray/v2ray：V2Ray 程序；
/usr/bin/v2ray/v2ctl：V2Ray 工具；
/etc/v2ray/config.json：配置文件；
/usr/bin/v2ray/geoip.dat：IP 数据文件
/usr/bin/v2ray/geosite.dat：域名数据文件

运行脚本位于系统的以下位置：

/etc/systemd/system/v2ray.service: Systemd
/etc/init.d/v2ray: SysV
脚本运行完成后，你需要：

编辑 /etc/v2ray/config.json 文件来配置你需要的代理方式；
运行 service v2ray start 来启动 V2Ray 进程；
之后可以使用 service v2ray start|stop|status|reload|restart|force-reload 控制 V2Ray 的运行。"
exit
;;
2)
sudo wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && sudo chmod +x bbr.sh &&sudo bash ./bbr.sh && echo -e "\n成功安装BBR。"
;;
3)
sudo wget --no-check-certificate https://raw.githubusercontent.com/tcp-nanqinlang/general/master/General/CentOS/bash/tcp_nanqinlang-1.3.2.sh
sudo bash tcp_nanqinlang-1.3.2.sh && echo -e "\n成功安装南琴浪版暴力魔改BBR。"
;;
4)
sudo systemctl start v2ray && echo "启动v2ray成功！" || echo "出现未知错误，命令执行失败！"
;;
5)
sudo systemctl stop v2ray && echo "停止v2ray成功！" || echo "出现未知错误，命令执行失败！"
;;
6)
sudo systemctl restart v2ray && echo "重启v2ray成功！" || echo "出现未知错误，命令执行失败！"
;;
7)
echo "请输入config.json的路径:"
read lujing
if [ -f $lujing ]
then
echo "指定config文件。" && v2ray -config=$lujing && echo "指定成功。" && echo "重启v2ray。" && sudo systemctl restart v2ray && echo "重启v2ray成功。|| echo "这个文件不是有效的config文件。""
else
echo "这不是有效文件！"
fi
;;
8)
echo "功能未实现"
echo  '{
  "inbounds": [{
    "port": 10044,
    "protocol": "vmess",
    "settings": {
      "clients": [
        {
          "id": "10e9df18-66c1-47cc-a019-43089ae6038f",
          "level": 1,
          "alterId": 64
        }
      ]
    }
  }],
  "outbounds": [{
    "protocol": "freedom",
    "settings": {}
  },{
    "protocol": "blackhole",
    "settings": {},
    "tag": "blocked"
  }],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": ["geoip:private"],
        "outboundTag": "blocked"
      }
    ]
  }
}'>./a.v2 && sudo mv /etc/v2ray/config.json /etc/v2ray/config.json.bak && sudo mv ./a.v2 /etc/v2ray/config.json && sudo systemctl restart v2ray || echo '出现错误，请自行检查！'







;;


bbr)
echo -e "如何以下两行值完全相同，为成功安装：
net.ipv4.tcp_congestion_control = bbr"
sysctl net.ipv4.tcp_congestion_control && echo "请确认是否安装。"
#test=$(sysctl net.ipv4.tcp_congestion_control)
#test1="net.ipv4.tcp_congestion_control = bbr"
#if [ $test = $test1 ] 
#then
#echo "成功安装！"
#else
#echo "未安装BBR。"
#fi
;;
q)
exit
;;
*)
echo "输入错误！"
;;
esac
done
