#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt install net-tools

sudo cp /etc/netplan/50-cloud-init.yaml /etc/netplan/51-cloud-init.yaml \
&& IP1_MAC="$(ifconfig ens5 | awk '/ether /{print $2}')"  \
&& IP2_MAC="$(ifconfig ens6 | awk '/ether /{print $2}')" \
&& sudo sed -i "s/ens5/ens6/g" /etc/netplan/51-cloud-init.yaml \
&& sudo sed -i "s/$IP1_MAC/$IP2_MAC/g" /etc/netplan/51-cloud-init.yaml \
&& sudo netplan --debug apply