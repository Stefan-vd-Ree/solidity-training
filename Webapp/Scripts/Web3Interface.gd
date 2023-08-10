extends Node

# The URL we will connect to
const websocket_url: String = "ws://145.131.21.160:1909"



# Our WebSocketClient instance
var _client = WebSocketClient.new()
var connected:bool = false

func _ready():
	# Connect base signals to get notified of connection open, close, and errors.
	_client.connect("connection_closed", self, "_closed")
	_client.connect("connection_error", self, "_closed")
	_client.connect("connection_established", self, "_connected")
	# This signal is emitted when not using the Multiplayer API every time
	# a full packet is received.
	# Alternatively, you could check get_peer(1).get_available_packets() in a loop.
	_client.connect("data_received", self, "_on_data")
	connect_to_web3server()
	
	
func connect_to_web3server():
	# Initiate connection to the given URL.
	var err = _client.connect_to_url(websocket_url)
	if err != OK:
		print("Unable to connect")
		set_process(false)
	else:
		print("connection succesful")

func _closed(was_clean = false):
	# was_clean will tell you if the disconnection was correctly notified
	# by the remote peer before closing the socket.
	print("Closed, clean: ", was_clean)
	set_process(false)

func _connected(proto = ""):
	connected = true
	# This is called on connection, "proto" will be the selected WebSocket
	# sub-protocol (which is optional)
	print("Connected with protocol: ", proto)
	
	# You MUST always use get_peer(1).put_packet to send data to server,
	# and not put_packet directly when not using the MultiplayerAPI.
#	var test_instruction: Array = var2bytes(["test_packet", "Test12345 packet"])
#	_client.get_peer(1).put_packet(test_instruction)
#
#	var tx_prop_hash: String = Keplr.retrieve_url_hash()
#	var instruction: Array = var2bytes(["retrieve_tx_prop", tx_prop_hash])
#	_client.get_peer(1).put_packet(instruction)
	

func _on_data():
	# Print the received packet, you MUST always use get_peer(1).get_packet
	# to receive data from server, and not get_packet directly when not
	# using the MultiplayerAPI.
	var pkt = _client.get_peer(1).get_packet()
	var instruction: Array = bytes2var(pkt)
	match instruction[0]:
		"signature_reply":
			get_node("/root/Main").return_signature(instruction[1])
		"return_tx_prop":
			pass
#			return_tx_prop(instruction[1])

func _process(delta):
	# Call this in _process or _physics_process. Data transfer, and signals
	# emission will only happen when calling this function.
	if connected:
		_client.poll()
		
func send_data(data_message):
	_client.get_peer(1).put_packet(data_message)
	
	
#func return_tx_prop(tx_prop: Dictionary):
#	Keplr.console.log(tx_prop)

