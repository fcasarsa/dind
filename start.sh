#!/bin/sh

cd /data

if ! test -f /data/dropbear_rsa_host_key
then
    dropbearkey -t rsa -f /data/dropbear_rsa_host_key
fi

if ! test -d /data/docker
then
    mkdir -p /data/docker
fi

if ! test -d /data/stack
then
    mkdir -p /data/stack
fi

screen -dmS dropbear dropbear -r /data/dropbear_rsa_host_key -E -F 
screen -dmS dockerd dockerd 

while ! docker ps > /dev/null
do
    sleep 1
done

cd /data/stack

while true
do
    if ! test -f docker-compose.yml
    then
        echo "looking for compose file"
        sleep 1    
    else
        echo "found."
        break
    fi
    
done

screen -dmS docker-compose docker-compose --remove-orphans up 
# exec dropbear -r /data/dropbear_rsa_host_key -E -F 

trap : TERM INT
tail -f /dev/null & wait


