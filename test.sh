#!/bin/bash

Filein=/tmp/SS-in.txt
Fileout=/tmp/SS-out.txt
Result=/home/linus/SS-Result.txt
CurMonth=`date +%b`
CurDay=`date +%d`


echo "Your host's listening ports."
ss -tulp | grep -o "users.*" > $Result
echo >> $Result

# Filter and writing the Incoming IPs within today.

if [ `echo ${CurDay:0:1}` ];then
        CurDay="${CurDay:1:1}"
        grep 'SS-in' /home/linus/github/Myscripts/test.ss.log | grep "$CurMonth  $CurDay" >> $Result
else
        grep 'SS-in' /home/linus/github/Myscripts/test.ss.log | grep "$CurMonth $CurDay" >> $Result
fi

