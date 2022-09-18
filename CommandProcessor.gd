extends Node


signal response_generated(response_text)

var current_room = null


func initialise(starting_room):
	change_room(starting_room)


func process_command(input: String) -> String:
	var words = input.split(" ", false)
	if words.size() == 0:
		return "Error: No words were parsed"
	var first_word = words[0]
	var second_word = " "
	if words.size() > 1:
		second_word = words[1].to_lower()
	match first_word.to_lower():
		"go":
			return go(second_word)
		"help":
			return help()
		_:
			return "Unrecognised command - please try again"


func go(second_word: String) -> String:
	if second_word == " ":
		return "Go where?"
	
	return "You go %s" % second_word


func help() -> String:
	return "Commands: go[location]"


func change_room(new_room: Roomz):
	current_room = new_room
	var strings = PoolStringArray([
		"You are now in: " + new_room.room_name + ". It is " + new_room.room_description,
		"Exits: "
	]).join("\n")
	emit_signal("response_generated", strings)
