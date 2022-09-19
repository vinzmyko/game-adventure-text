extends MarginContainer

onready var input_history_label = $Rows/InputHistory
onready var response_label = $Rows/Response


func set_text(response: String, input: String = ""):
	if input == "":
		input_history_label.queue_free()
	else:
		input_history_label.text = " > " + input
	
	response_label.bbcode_text = response

