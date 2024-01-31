## Script for fast installation and running OpenVPN server

Currently, docker-install script supports only Ubuntu.

With reference to https://hub.docker.com/r/kylemanna/openvpn/

### Usage:
* Specify IP address of your host. Port might be anything as long as it's free and below 65535.
Use udp protocol for gaming/streaming and tcp for downloading.
* Starts docker container and generates vpnconfig.ovpn file in the current folder. Config is a text file, so you can just copy and paste it to a new file on your OS.
* Config can be used with OpenVPN app for Windows, iOS or Android.
```
./install-docker.sh
./install-vpn.sh PROTOCOL IP PORT

Example:
./install-vpn.sh tcp 84.252.131.56 1194
```
