#! /bin/bash



if [[ 'grep -w 'NAME="Ubuntu"' /etc/os-release' ]]; then
    read -r -p "Enter ip addr:" ipaddr
    read -r -p "Enter your gateway:" gateway
    
   #sudo netplan apply
    #sudo netplan --debug apply
    sed -i 's/dhcp4: yes/dhcp4: no/g' /etc/netplan/50-cloud-init.yaml
    echo "           addresses: [$ipaddr/24]" >> /etc/netplan/50-cloud-init.yaml
    echo "           gateway4: $gateway" >> /etc/netplan/50-cloud-init.yaml
    echo "           nameservers:" >> /etc/netplan/50-cloud-init.yaml
    echo "             addresses: [8.8.8.8,8.8.4.4]" >> /etc/netplan/50-cloud-init.yaml
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
