extends Node

# The port we will listen to
const PORT = 1909
# Our WebSocketServer instance
var _server = WebSocketServer.new()

func _ready():
	# Connect base signals to get notified of new client connections,
	# disconnections, and disconnect requests.
	_server.connect("client_connected", self, "_connected")
	_server.connect("client_disconnected", self, "_disconnected")
	_server.connect("client_close_request", self, "_close_request")
	# This signal is emitted when not using the Multiplayer API every time a
	# full packet is received.
	# Alternatively, you could check get_peer(PEER_ID).get_available_packets()
	# in a loop for each connected peer.
	_server.connect("data_received", self, "_on_data")
	# Start listening on the given port.
	var err = _server.listen(PORT)
	if err != OK:
		print("Unable to start server")
		set_process(false)
	else:
		print("server started")

func _connected(id, proto):
	# This is called when a new peer connects, "id" will be the assigned peer id,
	# "proto" will be the selected WebSocket sub-protocol (which is optional)
	print("Client %d connected with protocol: %s" % [id, proto])

func _close_request(id, code, reason):
	# This is called when a client notifies that it wishes to close the connection,
	# providing a reason string and close code.
	print("Client %d disconnecting with code: %d, reason: %s" % [id, code, reason])

func _disconnected(id, was_clean = false):
	# This is called when a client disconnects, "id" will be the one of the
	# disconnecting client, "was_clean" will tell you if the disconnection
	# was correctly notified by the remote peer before closing the socket.
	print("Client %d disconnected, clean: %s" % [id, str(was_clean)])

func _on_data(id):
	# Print the received packet, you MUST always use get_peer(id).get_packet to receive data,
	# and not get_packet directly when not using the MultiplayerAPI.
	var pkt = _server.get_peer(id).get_packet()
	var instruction: Array = bytes2var(pkt)
	match instruction[0]:
		"signature_request":
			pass
			return_signature_request(instruction[1], id)
		"retrieve_tx_prop":
			pass
#			retrieve_tx_prop(instruction[1], id)
#	print("Got data from client %d: %s ... echoing" % [id, pkt.get_string_from_utf8()])

func _process(_delta):
	# Call this in _process or _physics_process.
	# Data transfer, and signals emission will only happen when calling this function.
	_server.poll()

func return_signature_request(enet_peer_id: String, id):
	var signature: float = TempStorage.peer_instruc_map[enet_peer_id]
	var signature_reply: Array = var2bytes(["signature_reply", signature])
	_server.get_peer(id).put_packet(signature_reply)
	

#func return_test_packet(test, id):
#	var test_instruction: Array = var2bytes(["test_packet_returned", test])
#	_server.get_peer(id).put_packet(test_instruction)
#
#
#func retrieve_tx_prop(prop_hash, id):
#	var tx_prop: Dictionary = TxsRequests.txs_requests[prop_hash]
#	var instruction: Array = var2bytes(["return_tx_prop", tx_prop])
#	_server.get_peer(id).put_packet(instruction)

