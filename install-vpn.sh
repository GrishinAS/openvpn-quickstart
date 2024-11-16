OVPN_DATA="ovpn-data-data"
PROTOCOL="$1"
HOST="$2"
PORT="$3"

sudo docker volume create --name $OVPN_DATA
sudo docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u "$PROTOCOL"://"$HOST"
sudo docker run -v $OVPN_DATA:/etc/openvpn -e EASYRSA_BATCH=1 --rm -it kylemanna/openvpn ovpn_initpki nopass

sudo docker run -v $OVPN_DATA:/etc/openvpn -d -p "$PORT":1194/"$PROTOCOL" --name openvpn --cap-add=NET_ADMIN kylemanna/openvpn

sudo docker run -v $OVPN_DATA:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full vpnconfig nopass

sudo docker run -v $OVPN_DATA:/etc/openvpn -e OVPN_PORT="$PORT" --rm kylemanna/openvpn ovpn_getclient vpnconfig > vpnconfig.ovpn