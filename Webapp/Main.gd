extends Node

var window = JavaScript.get_interface('window') setget _protectedSet, _protectedGet
#var keplr = JavaScript.get_interface('keplr') setget _protectedSet, _protectedGet
var console = JavaScript.get_interface('console') setget _protectedSet, _protectedGet


#var _accounts_callback = JavaScript.create_callback(self, "_accounts_callback")
#var _token_contract_callback = JavaScript.create_callback(self, "token_contract")
#var _nft_transfer_callback = JavaScript.create_callback(self, "nft_transfer_return")

onready var test_output: Node = get_node("/root/Main/UI/Main/TestOutput")

var enet_peer_id: String

var test_output_string: String = ""

func _protectedSet(_val):
	push_error('cannot access protected variable')

func _protectedGet():
	push_error('cannot access protected variable')

func _ready():
	## print the URL of the window
	var url_string = JavaScript.eval("window.location.href")
	test_output_string = test_output_string + " || " + url_string
	test_output.set_text(test_output_string)
	enet_peer_id = url_string.right(26)


func _on_Donate_pressed():
	test_output_string = test_output_string + " || " + str(enet_peer_id)
	test_output.set_text(test_output_string)
	var signature_request: Array = var2bytes(["signature_request", enet_peer_id])
	Web3Interface.send_data(signature_request)
	
	
func return_signature(signature):
	test_output_string = test_output_string + " || " + str(signature)
	test_output.set_text(test_output_string)
