wget https://github.com/kyemperor/ky_script/raw/master/1.sh&&echo chenggong!
echo 0>addtime
chmod 666 /root/addtime
chmod 777 1.sh
cp ./1.sh /usr/local/bin/mon.sh
echo '完成任务，正在重启'
sleep 3
reboot

 
wget https://github.com/kyemperor/ky_script/raw/master/debug.sh&&chmod a+x debug.sh&&sh debug.sh
