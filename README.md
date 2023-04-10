# SSHD for Docker with awake

This image contains an SSH daemon and rsync, as well as the tool awake to send WoL packages.

## Disclaimer
Credit: [panubo/docker-sshd](https://github.com/panubo/docker-sshd)

This image is based on panubo's docker-sshd image, with the sole addition of awake being installed.
The itentended use case is to use this image as a service to SSH into from another container running a scheduler and waking up other machines on the network using awake.


## Cheat Sheet
__Build__ 
```bash
docker build -t salvoxia/docker-sshd-awake:latest .
```
__Build Multi-Arch (buildx)__ 
 ```bash
 docker buildx create --name multi-platform-builder --platform linux/arm/v7,linux/arm64/v8,linux/amd64
 docker buildx build --builder multi-platform-builder -t salvoxia/docker-sshd-awake:latest .
```

## Broadcasting from a docker container
Usually it is not possible to send UDP broadcasts from a docker container to the "outside world" if the container is not using host networking mode but the docker bridge. Using host networking mode might not possible or desirable for security reasons.
As a workaround on Unix based host systems, it is possible to enable broadcast forwarding between the docker bridge and the bridged network interface. [This script by dhutchison](https://github.com/dhutchison/container-images/blob/master/homebridge/configure_docker_networks_for_wol.sh) can be used to persistently enable broadcast forwarding for a specified docker network.

### Example usage
The broadcast address needs to be specified explicitly for the broadcast to be routed correctly. Specify the brocast address for the network the machine to be waken up is part of.
```bash
awake -b 192.168.1.255 AB:CD:EF:12:34:56
```

