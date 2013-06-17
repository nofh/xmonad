#!/bin/bash
EMP="/home/nofh/Document/DocSystem/Aide/"


flag=""
ps aux | grep -v grep | grep xmessage | grep $1 
if [ $? -eq 0 ]
then
 echo "trouver"
 pidxm=$(ps aux | grep -v grep | grep xmessage | grep $1 | tr -s " " ":" | cut -d":" -f2)
 kill -n 15 $pidxm
else
 echo "pas trouver"
 xmessage -file "$EMP$1"
fi

exit $?
