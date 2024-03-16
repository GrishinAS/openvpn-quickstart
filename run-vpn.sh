OVPN_DATA="ovpn-data-data"
PROTOCOL="$1"
PORT="$3"
sudo docker run -v $OVPN_DATA:/etc/openvpn -d -p "$PORT":1194/"$PROTOCOL" -n openvpn --cap-add=NET_ADMIN kylemanna/openvpn
