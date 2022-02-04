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
useradd --system --no-create-home --shell=/sbin/nologin wp_rh
useradd --system --no-create-home --shell=/sbin/nologin db_rh
id_wp=$(id -u wp_rh)
id_db=$(id -u db_rh)

envfile=./.env

write_pid $envfile PUIDdb $id_db
write_pid $envfile PGIDdb $id_db

write_pid $envfile PUIDwp $id_wp
write_pid $envfile PGIDwp $id_wp

mkdir -p /appdata/romanahumus

#docker-compose up -d

exit 0