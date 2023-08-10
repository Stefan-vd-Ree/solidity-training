extends Node

var network = NetworkedMultiplayerENet.new()
var gateway_api = MultiplayerAPI.new()
#var ip = "127.0.0.1"
var ip = "145.131.21.160"
var port = 1910
var peer_id: int


func _ready():
	print("running")
	var donation_node = Node.new()
	donation_node.set_name("DonationInterface")
	var donation_script = load("res://Scripts/DonationInterface.gd")
	donation_node.set_script(donation_script)
	add_child(donation_node, true)
	connect_to_server()
	
	
func _process(_delta):
	if get_custom_multiplayer() == null:
		return
	if not custom_multiplayer.has_network_peer():
		return;
	custom_multiplayer.poll();
	
func connect_to_server():
	network.create_client(ip, port)
	set_custom_multiplayer(gateway_api)
	custom_multiplayer.set_root_node(self)
	custom_multiplayer.set_network_peer(network)

	network.connect("connection_failed", self, "_on_connection_failed")
	network.connect("connection_succeeded", self, "_on_connection_succeeded")
	

func _on_connection_failed():
	print("Failed to connect to game server")


func _on_connection_succeeded():
	peer_id = custom_multiplayer.get_network_unique_id() 
	print("Succesfully connected to game server")
	
	
func call_donate(donation_value):
	print("call out")
	rpc_id(1, "call_donate", donation_value, peer_id)
	
remote func return_donate(error):
	print("return in")
	print(error)
	if error != 0:
		# show popup and halt sequence
		pass
	else:
		# server encryption was succesful
		OS.shell_open("http://app.orbemwars.com/?" + str(peer_id))

