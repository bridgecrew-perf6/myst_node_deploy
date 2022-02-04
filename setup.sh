#!/bin/bash
chmod 640 .env

write_pid(){
    filename=$1
    thekey=$2
    newvalue=$3

    if ! grep -R "^[#]*\s*${thekey}=.*" $filename > /dev/null; then
    echo "APPENDING because '${thekey}' not found"
    echo "$thekey=$newvalue" >> $filename
    else
    echo "SETTING because '${thekey}' found already"
    sed -ir "s/^[#]*\s*${thekey}=.*/$thekey=$newvalue/" $filename
    fi
}

# Create sys users
useradd --system --no-create-home --shell=/sbin/nologin swag
id_swag=$(id -u swag)

envfile=./.env

write_pid $envfile PUID $id_swag
write_pid $envfile PGID $id_swag

mkdir -p /etc/swag

#docker-compose up -d

exit 0