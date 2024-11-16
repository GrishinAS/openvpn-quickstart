## Script for fast installation and running OpenVPN server

Currently, docker-install script supports only Ubuntu.

With reference to https://hub.docker.com/r/kylemanna/openvpn/

### Usage:
## Install and run
Specify IP address of your host, optional port which is free and below 65535 and optional protocol - tcp for data or upd for gaming/streaming.

If not specified default port will be 1194, protocol - tcp.

```shell
./install-docker.sh
./install-vpn.sh IP [PORT] [PROTOCOL]

Example:
./install-vpn.sh tcp 84.252.131.56 1194
```

Starts docker container and generates vpnconfig.ovpn file in the current folder. Config is just a text file, so you can just copy and paste it to a new file on your device.

Config can be used with OpenVPN app on any platform.

## Restart
If you need to run your vpn server again after your server restarted with the same IP, and it was already installed before with the script above just run:
```shell
./run-vpn.sh [PROTOCOL] [PORT]
```
If the IP of the server has changed after restart, run:
```shell
./reset-vpn.sh IP [PORT] [PROTOCOL] 
```
Configs will be recreated, so you need to reload them to your clients again.

###
Issues:

Works only with default port 1194 for now