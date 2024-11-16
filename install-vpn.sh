OVPN_DATA="ovpn-data-data"
HOST="$1"
PORT="${2:-1194}"
PROTOCOL="${3:-tcp}"

if [ -z "$HOST" ]; then
    echo "Error: Missing required parameters. Usage: $0 host [port] [protocol (tcp|udp)]" 1>&2
    exit 0
fi

echo "Connecting to host: $HOST"
echo "On port: $PORT"
echo "Using protocol: $PROTOCOL"

sudo docker volume create --name $OVPN_DATA
sudo docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u "$PROTOCOL"://"$HOST"
sudo docker run -v $OVPN_DATA:/etc/openvpn -e EASYRSA_BATCH=1 --rm -it kylemanna/openvpn ovpn_initpki nopass

sudo docker run -v $OVPN_DATA:/etc/openvpn -d -p "$PORT":1194/"$PROTOCOL" --name openvpn --cap-add=NET_ADMIN kylemanna/openvpn

sudo docker run -v $OVPN_DATA:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full vpnconfig nopass

sudo docker run -v $OVPN_DATA:/etc/openvpn -e OVPN_PORT="$PORT" --rm kylemanna/openvpn ovpn_getclient vpnconfig > vpnconfig.ovpn

echo "Setup finished. Use created vpnconfig.ovpn for connection"