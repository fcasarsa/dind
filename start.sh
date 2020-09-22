#!/bin/sh


# mount -t devtmpfs devtmpfs /dev
# causes open /dev/ptmx error


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

if ! test -d /data/dev
then
    mkdir -p /data/dev
fi

mount -t devtmpfs devtmpfs /data/dev

if ! test -d /data/stack/ext_storage
then
    mkdir -p /data/stack/ext_storage
fi

if test $EXT_STORAGE
then
    mount $EXT_STORAGE /data/stack/ext_storage
fi

screen -wipe

screen -dmS dropbear dropbear -r /data/dropbear_rsa_host_key -E -F 
screen -dmS dockerd /bin/sh -c "while true; do dockerd; sleep 1; done"


# trap : TERM INT
# tail -f /dev/null & wait

#while true
#do
#    tail -f /dev/null & wait
#    sleep 1
#done

exec tail -f /dev/null

# while ! docker ps > /dev/null
# do
#     sleep 1
# done

# cd /data/stack

# while true
# do
#     if ! test -f docker-compose.yml
#     then
#         echo "looking for compose file"
#         sleep 1    
#     else
#         echo "found."
#         break
#     fi
    
# done

# screen -dmS docker-compose docker-compose --remove-orphans up 


# exec dropbear -r /data/dropbear_rsa_host_key -E -F 



