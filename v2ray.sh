#!/bin/bash
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
bash <(curl -L -s https://install.direct/go.sh) && echo -e "\成功安装v2ray！" && echo -e "
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
;;
2)
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh && echo -e "\n成功安装BBR。"
;;
3)
wget --no-check-certificate https://raw.githubusercontent.com/tcp-nanqinlang/general/master/General/CentOS/bash/tcp_nanqinlang-1.3.2.sh
bash tcp_nanqinlang-1.3.2.sh && echo -e "\n成功安装南琴浪版暴力魔改BBR。"
;;
4)
systemctl start v2ray && echo "启动v2ray成功！" || echo "出现未知错误，命令执行失败！"
;;
5)
systemctl stop v2ray && echo "停止v2ray成功！" || echo "出现未知错误，命令执行失败！"
;;
6)
systemctl restart v2ray && echo "重启v2ray成功！" || echo "出现未知错误，命令执行失败！"
;;
7)
echo "请输入config.json的路径:"
read lujing
if [ -f $lujing ]
then
echo "指定config文件。" && v2ray -config=$lujing && echo "指定成功。" && echo "重启v2ray。" && systemctl restart v2ray && echo "重启v2ray成功。|| echo "这个文件不是有效的config文件。""
else
echo "这不是有效文件！"
fi
;;
8)
json=config.json.ky
echo "{">$json
echo -e " \"log\": {
    \"access\": \"\",
    \"error\": \"\",
    \"loglevel\": \"warning\"
  },
  \"inbounds\": [
    {">>$json
echo -e "
请输入本地代理端口port（defalut:1080):"
read port
if [ -z $port ]
then
port=1080
echo "------您使用了默认的本地代理端口1080。"
else
echo "------您输入的本地代理端口为$port。"
fi
echo -e "      \"port\": $port, " >>$json
echo -e "      \"listen\": "127.0.0.1",
      \"protocol\": \"socks\",
      \"sniffing\": {
        \"enabled\": true,
        \"destOverride\": [
          \"http\",
          \"tls\"
        ]
      },
      \"settings\": {
        \"auth\": \"noauth\",
        \"udp\": true,
        \"ip\": null,
        \"clients\": null
      },
      \"streamSettings\": null
    }
  ],
  \"outbounds\":[
    {
      \"protocol\":\"vmess\",
      \"settings\":{
        \"vnext\":[
          {">>$json
echo -e "
请输入代理服务器IP地址（defalut:0.0.0.0):"
read ip 
if [ -z $ip ]
then
ip="0.0.0.0"
echo "------您未输入代理服务器IP。"
else
echo "------您输入的代理服务器IP地址为$ip。"
fi
echo -e "            \"address\":\"$ip\",">>$json
echo -e "
请输入代理服务器端口port（defalut:0):"
read port
if [ -z $port ]
then
port="0"
echo "------您未输入代理服务器端口。"
else
echo "------您输入的代理服务器端口为$port。"
fi
echo -e "            \"port\":$port,">>$json
echo -e "            \"users\":[
              {">>$json
echo -e "
请输入代理服务器ID（defalut:12345678-1234-1234-1234-123456789012):"
read id
if [ -z $id ]
then
id="12345678-1234-1234-1234-123456789012"
echo "------您未输入代理服务器ID。"
else
echo "------您输入的代理服务器端口为$ip。"
fi
echo -e "                \"id\":\"$id\",">>$json
echo -e "
请输入代理服务器额外ID（defalut:64):"
read alterid
if [ -z $alterid ]
then
alterid="64"
echo "------您未输入代理服务器额外ID。"
else
echo "------您输入的代理服务器额外ID为$alterid。"
fi
echo -e "                \"alterId\":$alterid">>$json
echo -e "              }
            ]
          }
        ]
      },
      \"tag\":\"out-0\",
      \"streamSettings\":{
        \"network\":\"tcp\",
        \"security\":\"none\",
        \"tcpSettings\":{}
      }
    },
    {
      \"tag\":\"direct\",
      \"protocol\":\"freedom\",
      \"settings\":{}
    },
    {
      \"tag\":\"blocked\",
      \"protocol\":\"blackhole\",
      \"settings\":{}
    }
  ],
  \"routing\":{
    \"domainStrategy\":\"IPOnDemand\",
    \"rules\":[
      {
        \"type\":\"field\",
        \"ip\":[
          \"geoip:private\"
        ],
        \"outboundTag\":\"direct\"
      }
    ]
  },
  \"policy\":{},
  \"reverse\":{},
  \"transport\":{}
}">>$json
while true
do
echo "是否启用此config？y or n"
read a
if [ $a = y ]
then
echo "需要root权限。"
mv /etc/v2ray/config.json /etc/v2ray/config.ky.json.bak && echo "原文件已备份为config.ky.json.bak"
mv ./$json /etc/v2ray/config.json && echo "复制完成，开始重启v2ray."
systemctl restart v2ray && echo "成功重启v2ray!"
break
fi
if [ $a = n ]
then
echo "您的配置文件保存为当前目录下的$json，欢迎使用。"
break
fi
echo "输入错误，请重新输入。"
done
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
