extends Node

var network = NetworkedMultiplayerENet.new()
var gateway_api = MultiplayerAPI.new()
var port = 1910
var max_players = 100



func _ready():
	start_server()
	var donation_node = Node.new()
	donation_node.set_name("DonationInterface")
	var donation_script = load("res://Scripts/DonationInterface.gd")
	donation_node.set_script(donation_script)
	add_child(donation_node, true)
	
	
func _process(delta):
	if not custom_multiplayer.has_network_peer():
		return;
	custom_multiplayer.poll();


func start_server():
	network.create_server(port, max_players)
	set_custom_multiplayer(gateway_api)
	custom_multiplayer.set_root_node(self)
	custom_multiplayer.set_network_peer(network)
	print("Server started")
	
	network.connect("peer_connected", self, "_peer_connected")
	network.connect("peer_disconnected", self, "_peer_disconnected")

func _peer_connected(player_id):
	print("User " + str(player_id) + " Connected")

func _peer_disconnected(player_id):
	print("User " + str(player_id) + " Disconnected")
	
	
remote func call_donate(donation_value: float, peer_id: int):
	var p_id = get_tree().get_rpc_sender_id()
	TempStorage.peer_instruc_map[str(peer_id)] = donation_value
	var error: int = check_encryption_success()
	rpc_id(p_id, "return_donate", error)
	

func check_encryption_success():
	## this is check for succesful encryption
	var error_code: int = 0
	return error_code
