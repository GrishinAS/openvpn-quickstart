OVPN_DATA="ovpn-data-data"
PROTOCOL="$1"
HOST="$2"
PORT="$3"


sudo docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u "$PROTOCOL"://"$HOST"
sudo docker run -v $OVPN_DATA:/etc/openvpn -e EASYRSA_BATCH=1 --rm -it kylemanna/openvpn ovpn_initpki nopass
sudo docker run -v $OVPN_DATA:/etc/openvpn -e OVPN_PORT="$PORT" --rm kylemanna/openvpn ovpn_getclient vpnconfig > vpnconfig.ovpn
sudo docker stop openvpn
sudo docker rm openvpn
sudo docker run -v $OVPN_DATA:/etc/openvpn -d -p "$PORT":1194/"$PROTOCOL" -n openvpn --cap-add=NET_ADMIN kylemanna/openvpn