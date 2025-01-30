#!/bin/bash

docker run -d --name ubuntu pycontribs/ubuntu:latest sleep infinity
docker run -d --name centos7 pycontribs/centos:7 sleep infinity
docker run -d --name fedora pycontribs/fedora:latest sleep infinity

if [ "$(docker ps -q -f name=ubuntu)" ] && [ "$(docker ps -q -f name=centos7)" ] && [ "$(docker ps -q -f name=fedora)" ]; then
    echo "Контейнеры запущены"
else
    echo "Один из контейнеров не запустился"
    exit 1
fi

ansible-playbook -i inventory/prod.yml site.yml

if [ $? -eq 0 ]; then
    echo "Плейбук выполнился успешно"
else
    echo "Плейбук не выполнился"
    exit 1
fi

docker stop ubuntu centos7 fedora

if [ "$(docker ps -aq -f status=exited -f name=ubuntu)" ] && [ "$(docker ps -aq -f status=exited -f name=centos7)" ] && [ "$(docker ps -aq -f status=exited -f name=fedora)" ]; then
    echo "Контейнеры останановлены"
else
    echo "Контейнеры не завершили работу"
    exit 1
fi