FROM ubuntu:20.04

RUN apt-get update && \
	apt-get install -y wget grub-efi grub-pc-bin mtools xorriso && \
	rm -rf /var/lib/apt/lists/*

ENV K3OS_VERSION v0.21.5-k3s2r1
ENV K3OS_FILENAME k3os-amd64.iso

ADD build.sh /build.sh

CMD [ "sh", "-c", "./build.sh" ]
