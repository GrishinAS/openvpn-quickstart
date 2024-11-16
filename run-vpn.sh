OVPN_DATA="ovpn-data-data"
PROTOCOL="${1:-tcp}"
PORT="${2:-1194}"

echo "Using protocol: $PROTOCOL"
echo "On port: $PORT"
sudo docker run -v $OVPN_DATA:/etc/openvpn -d -p "$PORT":1194/"$PROTOCOL" --name openvpn --cap-add=NET_ADMIN kylemanna/openvpn
