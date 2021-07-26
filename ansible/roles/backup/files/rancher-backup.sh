#!/bin/bash
RANCHER_SERVER_NAME=$(docker ps -a --format "{{.Image}} {{.Names}}" | grep -i "rancher/rancher" | cut -d' ' -f2)
TODAY_DATE=$(date +%Y%m%d)
RANCHER_COPY_NAME=rancher-data-${TODAY_DATE}
BACKUP_PATH=~/ab/misc/rancher
RANCHER_BACKUP_FILE=rancher-data-backup-${TODAY_DATE}.tar.gz

mkdir -p ${BACKUP_PATH}

docker pull rancher/rancher:latest

docker stop ${RANCHER_SERVER_NAME}
docker create --volumes-from ${RANCHER_SERVER_NAME} --name rancher-backup rancher/rancher:latest
docker run --rm --volumes-from rancher-backup -v /home/ubuntu/backups:/backup alpine tar zcf /backup/backup.tar.gz /var/lib/rancher

docker start ${RANCHER_SERVER_NAME}
docker rm -f rancher-backup