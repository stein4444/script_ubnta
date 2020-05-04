#! /bin/bash

if [[ 'grep -w 'NAME="Ubuntu"' /etc/os-release' ]]; then
    read -r -p "Enter ip addr:" ipaddr
    read -r -p "Enter your gateway:" gateway
    sudo sh -c "echo 'network:' > /etc/netplan/50-cloud-init.yaml"
    sudo sh -c "echo '  version: 2' >> /etc/netplan/50-cloud-init.yaml"
    sudo sh -c "echo '  renderer: networkd' >> /etc/netplan/50-cloud-init.yaml"
    sudo sh -c "echo '  ethernets:' >> /etc/netplan/50-cloud-init.yaml"
    sudo sh -c "echo '    enp0s3:' >> /etc/netplan/50-cloud-init.yaml"
    sudo sh -c "echo '      dhcp4: no' >> /etc/netplan/50-cloud-init.yaml"
    sudo sh -c "echo '      addresses: [$ipaddr/24]' >> /etc/netplan/50-cloud-init.yaml"
    sudo sh -c "echo '      gateway4: $gateway' >> /etc/netplan/50-cloud-init.yaml"
    sudo sh -c "echo '      nameservers:'>> /etc/netplan/50-cloud-init.yaml"
    sudo sh -c "echo '        addresses: [8.8.8.8,8.8.4.4]' >> /etc/netplan/50-cloud-init.yaml"
    sudo netplan apply
    
else
    read -r -p "Enter ip addr:" ipaddr
    read -r -p "Enter your netmask:" netmask
    read -r -p "Enter your gateway:" gateway
    sed -i 's/BOOTPROTO="dhcp"/BOOTPROTO=static/g' /etc/sysconfig/network-scripts/ifcfg-enp0s3
    echo "IPADDR=$ipaddr" >> /etc/sysconfig/network-scripts/ifcfg-enp0s3
    echo "NETMASK=$netmask" >> /etc/sysconfig/network-scripts/ifcfg-enp0s3
    echo "GATEWAY=$getaway" >> /etc/sysconfig/network-scripts/ifcfg-enp0s3
    echo "DNS1=8.8.8.8" >> /etc/sysconfig/network-scripts/ifcfg-enp0s3
    if [[ $? != 0 ]]; then
        echo "$?"
        echo "Eror"
    else
        echo "$?"
        echo "good joob u sat static ip"
    fi
fi
