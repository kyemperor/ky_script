#!/bin/sh

echo '0 4 * * * /sbin/reboot
*/3 * * * * /root/mon.sh'>/var/spool/cron/crontabs/root
