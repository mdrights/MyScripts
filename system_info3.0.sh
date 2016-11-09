#!/bin/bash
# Showing system info. 2015-12-23
# And email them. 2016-03-29
# Remove colorized tag for email_version. 2016-06-11
# Updated: send the info to my TG bot. 2016-08-25


Token="242296535:AAFAzUU1YUH5n8G9Xi-VJQauVJmCHNt5ZMs"

touch $HOME/system-info.txt 
Result="$HOME/system-info.txt"

echo -e "***** HOSTNAME INFORMATION *****" > $Result
hostnamectl >> $Result
echo >> $Result

echo -e "***** DISK SPACE USAGE *****" >> $Result
df -h >> $Result
echo >> $Result

echo -e "***** FREE AND USED MEMORY *****" >> $Result
free -h >> $Result
echo >> $Result

echo -e "***** SYSTEM UPTIME AND LOAD *****" >> $Result
uptime >> $Result
echo >> $Result

echo -e "***** CURRENTLY LOGGED-IN USERS *****" >> $Result
who >> $Result
echo >> $Result

#echo -e "\e[31;43m***** TOP 5 MEMORY-CONSUMING PROCESSES *****\e[0m" 
#ps -e o pid,-%mem,%cpu,comm --sort=%mem | head -n 6
#echo



#Checking FILE SYSTEM USAGE

echo >> $Result
echo -e "CHECKING FILE SYSTEM USAGE...." >> $Result

THRESOLD=80
n=2
while [ $n -le $(echo "`df`" | wc -l) ]
do
	NUM=$n
	FILESYSTEM=$(echo "`df`" | awk 'NR=='$NUM' {print $1}') 
	PERCENTAGE=$(echo "`df`" | awk 'NR=='$NUM' {print $5}')
	USAGE=${PERCENTAGE%?}
	# echo "$FILESYSTEM; $PERCENTAGE; $USAGE." >> $Result
	n=$[ $n + 1 ]

if [ $USAGE -gt $THRESOLD ]; then
	echo >> $Result
	echo "The remaining available space in $FILESYSTEM is critically low. Used: $PERCENTAGE" >> $Result
fi

done
#< <(df -h --total | grep -vi filesystem)

# The open ports and services.
echo -e "***** OPEN SERVICES *****" >> $Result
ss -tulp | grep -o "users.*" >> $Result

echo -e "***** ESTABLISHED CONNECTIONS *****" >> $Result
ss -tu >> $Result



# echo "Sending email..." >> $Result
# cat $Result | mutt -s "VPS info at `date`, `hostname`" mdrights@icloud.com

echo "Sending the result to my TG bot:"
w3m "https://api.telegram.org/bot$Token/sendmessage?chat_id=64960773&text=`cat $Result`" 1>&/dev/null

echo

echo -e "Done." >> $Result

echo "Save to $Result."

echo
exit 0


