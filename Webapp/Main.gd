extends Node

var window = JavaScript.get_interface('window') setget _protectedSet, _protectedGet
var console = JavaScript.get_interface('console') setget _protectedSet, _protectedGet




onready var test_output: Node = get_node("/root/Main/UI/Main/TestOutput")
var enet_peer_id: String
var test_output_string: String = ""


var bravo_address: String = "0x2741abA2ece6554BD3d33aC295B87133DE87A9CE"
var message: String = "Hello World"
var signature

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


func _on_Confirm_pressed():
	## Working connectivity code
#	test_output_string = test_output_string + " || " + str(enet_peer_id)
#	test_output.set_text(test_output_string)
#	var signature_request: Array = var2bytes(["signature_request", enet_peer_id])
#	Web3Interface.send_data(signature_request)
	
	## Testing code for MetaMask integration
	var test_provider = window.getProvider()
	
	console.log(test_provider);
	var test_signer = window.getSigner(test_provider)
	console.log(test_signer);
	
#	window.sendEther(test_signer, bravo_address, 0.1)
	
	signature = window.signMessage(test_signer, message)
	print(signature)

	
func _on_Verify_pressed():
	window.verifySignature(message, signature, bravo_address)
	
#	var ethers = window.get_interface('_ethers')
#	var provider = JavaScript.eval("new window._ethers.providers.Web3Provider(window.ethereum)")
#	JavaScript.eval("console.log(provider)")
	
#	const provider = new ethers.providers.Web3Provider(window.ethereum)
#	const signer = provider.getSigner()
#	const contract = new ethers.Contract(contractAddress, abi, signer)
#	try {
#	  const transactionResponse = await contract.fund({
#		value: ethers.utils.parseEther(ethAmount),
#	  })
#	  await listenForTransactionMine(transactionResponse, provider)
#	} catch (error) {
#	  console.log(error)
#	}
	
	
func return_signature(signature):
	test_output_string = test_output_string + " || " + str(signature)
	test_output.set_text(test_output_string)


