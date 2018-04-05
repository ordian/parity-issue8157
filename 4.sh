# connect the nodes
addr1="$(curl --data '{"jsonrpc":"2.0","method":"parity_enode","params":[],"id":0}' -H "Content-Type: application/json" -X POST localhost:8541 | jq '.result')"
addr2="$(curl --data '{"jsonrpc":"2.0","method":"parity_enode","params":[],"id":0}' -H "Content-Type: application/json" -X POST localhost:8542 | jq '.result')"

echo "the first  address is: $addr1"
echo "the second address is: $addr2"

curl --data "{\"jsonrpc\":\"2.0\",\"method\":\"parity_addReservedPeer\",\"params\":[$addr1],\"id\":0}" -H "Content-Type: application/json" -X POST localhost:8540

curl --data "{\"jsonrpc\":\"2.0\",\"method\":\"parity_addReservedPeer\",\"params\":[$addr2],\"id\":0}" -H "Content-Type: application/json" -X POST localhost:8540
