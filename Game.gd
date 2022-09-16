extends Control


const InputResponse = preload("res://InputResponse.tscn")


var max_scroll_length: int


onready var history_rows : VBoxContainer = $Background/MarginContainer/Rows/GameInfo/Scroll/HistoryRows
onready var scroll := $Background/MarginContainer/Rows/GameInfo/Scroll
onready var scrollbar = scroll.get_v_scrollbar()


func _ready() -> void:
	scrollbar.connect("changed", self, "handle_scrollbar_changed")
	max_scroll_length = scrollbar.max_value


func handle_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = max_scroll_length

func _on_Input_text_entered(new_text: String) -> void:
	var input_response := InputResponse.instance()
	input_response.set_text(new_text, "This is a response!")
	history_rows.add_child(input_response)

