#!/bin/sh
echo `date`>>/root/mon.log
icount=`ps aux |grep firefox|grep -v grep|wc -l`
if [ $icount -lt 1 ] ;then
 export DISPLAY=localhost:1 && firefox --profile ~/.alexa/alexa --new-tab 'https://www.alexamaster.net/Master/132997' &
 echo 'grep firefox is null.
 '>>/root/mon.log
fi
addtime=`cat /root/addtime`
if [ $addtime -ge 4 ]
then
 echo '12-minutes is here.'>>/root/mon.log
pkill firefox
 echo 'killall firefox'>>/root/mon.log
sleep 3
 export DISPLAY=localhost:1 && firefox --profile ~/.alexa/alexa --new-tab 'https://www.alexamaster.net/Master/132997' &
  echo 'Start firefox'>>/root/mon.log
  echo "0">/root/addtime
else
 echo `expr $addtime + 1`>/root/addtime
fi
