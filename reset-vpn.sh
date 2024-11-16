OVPN_DATA="ovpn-data-data"
PROTOCOL="$1"
HOST="$2"
PORT="$3"

if [[ -z "$PROTOCOL" ] || [ -z "$HOST" ] || [ -z "$PORT" ]]; then
    echo "Please provide parameters in format: protocol[tcp;udp] host port" 1>&2
    exit 1
fi

# generate openvpn generator config
sudo docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -e OVPN_PORT="$PORT" -u "$PROTOCOL"://"$HOST"
# generate keys
sudo docker run -v $OVPN_DATA:/etc/openvpn -e EASYRSA_BATCH=1 --rm -it kylemanna/openvpn ovpn_initpki nopass
# build rsa config
sudo docker run -v $OVPN_DATA:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full vpnconfig nopass
# generate client OpenVPN config
sudo docker run -v $OVPN_DATA:/etc/openvpn -e OVPN_PORT="$PORT" --rm kylemanna/openvpn ovpn_getclient vpnconfig > vpnconfig.ovpn
# run the service
sudo docker run -v $OVPN_DATA:/etc/openvpn -d -p "$PORT":1194/"$PROTOCOL" --name openvpn --cap-add=NET_ADMIN kylemanna/openvpn