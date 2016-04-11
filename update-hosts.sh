#!/bin/bash

# Update the malicious hosts list from www.mwsl.org.cn, every Tuesday.

/usr/bin/curl -o /etc/hosts "http://hosts.mwsl.org.cn/hosts.txt"

if [ "$?" == 0 ]; then
	echo "Host list is downloaded.."
else
	echo "Host list has not been successfully downloaded. Exit and try it again."
fi

cat << EOF >> /etc/hosts

# Subnet hosts
127.0.1.1	kali-T450
192.168.10.10	raspberrypi

EOF

echo "Done. Now the hosts file is : "
ls -l /etc/hosts

exit

