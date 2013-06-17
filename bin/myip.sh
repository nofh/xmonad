#!/bin/bash
echo "Ip:"  $(links -dump http://monip.org | grep "IP" | cut -d":" -f2 | cut -d" " -f2)
exit 0
