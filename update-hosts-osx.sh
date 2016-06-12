#!/bin/bash

# Update the malicious hosts list from www.mwsl.org.cn, every Tuesday.

/usr/bin/curl -o /etc/hosts "http://hosts.mwsl.org.cn/hosts.txt"

if [ "$?" == 0 ]; then
	echo "Host list is downloaded.."
else
	echo "Host list has not been successfully downloaded. Exit and try it again."
fi

cat << EOF >> /etc/hosts

##
# Host Database
#
# localhost is used to configure the loopback interface
# when the system is booting.  Do not change this entry.
##
127.0.0.1	localhost
255.255.255.255	broadcasthost
::1             localhost 
192.168.10.10	Raspberrypi
127.0.0.1	icloud.com
127.0.0.1	apple.com


EOF

echo "Done. Now the hosts file is : "
ls -l /etc/hosts

exit

