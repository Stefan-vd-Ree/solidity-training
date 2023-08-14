extends Node


var js_path: String = "res://Scripts/JavaScript/sign.js"
var js_apath: String

var public_test_address = "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2".to_lower()
var keyArray = ["atk", "def", "rof"]
var valueArray = ["256", "459", "20"]

## "[\"atk\", \"def\", \"rof\"]" "[\"256\", \"459\", \"20\"]" 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2

func _ready():
	js_apath = ProjectSettings.globalize_path(js_path)
	print(js_apath)
	
	yield(get_tree(), "idle_frame")
	
#	var message: String = "Hello World"
	
	execute_js_code()
	

func execute_js_code():
	## We have have have have have have to include the known wallet address of the  user
	## in the signing of the signature and use msg.sender in the verification function!!
	## otherwise we are exposed to both eavesdropping and more importantly front-running attacks
	
	var key_array_b64 = encode_array(keyArray)
	var value_array_b64 = encode_array(valueArray)
	
	var stdout = []
	var ERR = OS.execute("node", [js_apath, key_array_b64, value_array_b64, public_test_address], true, stdout)
	if ERR == OK:
		var output_string = ""
		for line in stdout:
			output_string += line + "\n"
		print("JS script output:", output_string)
	else:
		print("ERROR EXECUTING 'sign.js' WITH ERROR CODE: %s"%ERR)

func encode_array(array: Array):
	var array_as_json = JSON.print(array)
	var array_as_utf: PoolByteArray = array_as_json.to_utf8()
	var array_as_string: String = array_as_utf.get_string_from_utf8()
	var array_as_base64 = Marshalls.utf8_to_base64(array_as_string)
	return array_as_base64
