#!/bin/bash
set -eo pipefail

if [[ -z $K3OS_VERSION ]]; then
    echo "Environment variable K3OS_VERSION not set!"
    exit 1
fi

if [[ -z $K3OS_FILENAME ]]; then
    echo "Environment variable K3OS_FILENAME not set!"
    exit 1
fi

if [[ -z $HOST ]]; then
    echo "Environment variable HOST not set!"
    exit 1
fi

K3OS_RELEASE_URL="https://github.com/rancher/k3os/releases/download/${K3OS_VERSION}/${K3OS_FILENAME}"
K3OS_REMASTERED_FILENAME="k3os-${HOST}.iso"

wget -q --show-progress $K3OS_RELEASE_URL -O /tmp/$K3OS_FILENAME
if [[ ! -f /tmp/$K3OS_FILENAME ]]; then
    echo "File ${K3OS_RELEASE_URL} could not be downloaded."
    exit 1
fi

mkdir -p /source
mkdir -p /iso/boot/grub
mount -o loop /tmp/$K3OS_FILENAME /source

cp -rf /source/k3os /iso/
cp /source/boot/grub/grub.cfg /iso/boot/grub/

if [[ -f /custom/config.yml ]]; then
    cp -f /custom/config.yml /iso/k3os/system/config.yaml
fi
if [[ -f /custom/grub.cfg ]]; then
    cp -f /custom/grub.cfg /iso/boot/grub/grub.cfg
fi

mkdir -p /output
cd /output
grub-mkrescue -o ${K3OS_REMASTERED_FILENAME} /iso/ -- -volid K3OS
