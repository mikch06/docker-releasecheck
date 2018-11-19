#!/bin/sh

#
# Docker release check
#

# debug
###set -x

DOCKERURL="https://download.docker.com/linux/centos/7/x86_64/stable/Packages/"
#LASTREL=$(cat /tmp/latestdockerrel)

CURRENTREL=$(curl -s $DOCKERURL|grep -Eo '[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}'|sort|tail -n1) 2>/dev/null

if [ ! -f "/tmp/latestdockerrel" ]; then
        echo "==================="
       echo "There is no LastRelease, please run script a second time"
        echo "==================="
        echo $CURRENTREL > /tmp/latestdockerrel
        exit
fi

LASTREL=$(cat /tmp/latestdockerrel)
if [ "$LASTREL" != "$CURRENTREL" ]; then
        echo "==================="
        echo "There is a new docker-ce release available!"
        echo "==================="
        echo $CURRENTREL > /tmp/latestdockerrel
        echo " Please download it: https://download.docker.com/linux/centos/7/x86_64/stable/Packages/"|mail -s "New docker-ce release available!" <E-Mail address>
else
        echo "==================="
        echo "The current release is still the same."
        echo "But you can check: https://download.docker.com/linux/centos/7/x86_64/stable/Packages/"
        echo "==================="
fi
