FROM ubuntu:20.04

RUN apt-get update && \
	apt-get install -y wget grub-common xorriso && \
	rm -rf /var/lib/apt/lists/*

ENV k3os_version v0.21.5-k3s2r1
ENV k3os_filename k3os-amd64.iso

ADD build.sh /build.sh

CMD [ "sh", "-c", "./build.sh" ]
