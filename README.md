# K3OS Builder

A one-time-run image that will remaster a K3OS image based on a number of environment variables.

* K3OS_VERSION - the version of K3OS to use (e.g. ```v0.21.5-k3s2r1```)
* K3OS_FILENAME - the name of the original K3OS image (e.g. ```k3os-amd64.iso```)
* HOST - the name of the host for which you are building this K3OS image.

The following volumes are expected to be passed through to the image:

* ```/custom``` - contains the custom ```grub.cfg``` and ```config.yaml``` that will be applied to the remastered image.
* ```/output``` - is where the remastered image ```k3os-HOST.iso``` will be placed.
