# connect the nodes
addr="$(curl --data '{"jsonrpc":"2.0","method":"parity_enode","params":[],"id":0}' -H "Content-Type: application/json" -X POST localhost:8541 | jq '.result')"

echo "the node address is: $addr"

curl --data "{\"jsonrpc\":\"2.0\",\"method\":\"parity_addReservedPeer\",\"params\":[$addr],\"id\":0}" -H "Content-Type: application/json" -X POST localhost:8540
