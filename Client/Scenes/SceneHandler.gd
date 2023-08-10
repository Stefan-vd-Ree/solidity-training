extends Node


func _on_ButtonDonate_pressed():
	## Check for valid input
	var input: float = float($UI/Main/InputAmount.get_text())
	if input != 0:
		MainInterface.call_donate(input)
		
