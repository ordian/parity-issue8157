# 1 authority address should be 0x00bd138abd70e2f00903268f3db08f2d25677c9e
curl --data '{"jsonrpc":"2.0","method":"parity_newAccountFromPhrase","params":["node0", "node0"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8540
# user address should be 0x004ec07d2329997267ec62b4166639513386f32e
curl --data '{"jsonrpc":"2.0","method":"parity_newAccountFromPhrase","params":["user", "user"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8540
# 2 authority address should be 0x00aa39d30f0d20ff03a22ccfc30b7efbfca597c2
curl --data '{"jsonrpc":"2.0","method":"parity_newAccountFromPhrase","params":["node1", "node1"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8541
# 3 authority address should be 0x002e28950558fbede1a9675cb113f0bd20912019
curl --data '{"jsonrpc":"2.0","method":"parity_newAccountFromPhrase","params":["node2", "node2"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8542

killall parity
