extends Node


var current_room = null


func initialise(starting_room) -> String:
	return change_room(starting_room)


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
	
	if current_room.exits.keys().has(second_word):
		var change_response = change_room(current_room.exits[second_word])
		return PoolStringArray(["You go %s." % second_word, change_response]).join("\n")
	else:
		return "This room has no exits in that direction"


func help() -> String:
	return "Commands: go[location]"


func change_room(new_room: Roomz) -> String:
	current_room = new_room
	var exit_string = PoolStringArray(new_room.exits.keys()).join(" ")
	var strings = PoolStringArray([
		"You are now in: " + new_room.room_name + ". It is " + new_room.room_description,
		"Exits: " + exit_string
	]).join("\n")
	
	return strings
