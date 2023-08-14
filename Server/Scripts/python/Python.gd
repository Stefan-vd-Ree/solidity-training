extends Node


var py_path: String = "res://Scripts/python/web3elements.py"

var py_apath: String

func _ready():
	py_apath = ProjectSettings.globalize_path(py_path)
	print(py_apath)
	
	yield(get_tree(), "idle_frame")
	
	var message: String = "Hello World"
	
	execute_python_code(message)
	

func execute_python_code(message: String):
	var stdout = []
	var ERR = OS.execute("python", [py_apath, message], true, stdout)
	if ERR == OK:
		var output_string = ""
		for line in stdout:
			output_string += line + "\n"
		print("Python script output:", output_string)
	else:
		print("ERROR EXECUTING 'web3elements.py' WITH ERROR CODE: %s"%ERR)
	


