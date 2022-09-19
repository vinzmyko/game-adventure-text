extends Control


onready var game_info = $Background/MarginContainer/Rows/GameInfo
onready var command_processor = $CommandProcessor
onready var room_manager = $RoomManager
onready var player = $Player


func _ready() -> void:
	game_info.create_response(Types.wrap_text("Welcome to a text adventure game. You can type 'help' to a all the availiable commands", Types.COLOUR_SYSTEM))
	
	var starting_room_response = command_processor.initialise(room_manager.get_child(0), player)
	game_info.create_response(starting_room_response)


func _on_Input_text_entered(new_text: String) -> void:
	if new_text.empty():
		return
	
	var response = command_processor.process_command(new_text)
	game_info.create_response_with_input(response, new_text)

