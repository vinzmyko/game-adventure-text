extends Node


var current_room = null
var player = null


func initialise(starting_room, player) -> String:
	self.player = player
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
		"take":
			return take(second_word)
		"drop":
			return drop(second_word)
		"inventory":
			return inventory()
		"help":
			return help()
		_:
			return "Unrecognised command - please try again"


func go(second_word: String) -> String:
	if second_word == " ":
		return "Go where?"
	
	if current_room.exits.keys().has(second_word):
		var exit = current_room.exits[second_word]
		var change_response = change_room(exit.get_other_room(current_room))
		return PoolStringArray(["You go %s." % second_word, change_response]).join("\n")
	else:
		return "This room has no exits in that direction"


func take(second_word: String) -> String:
	if second_word == " ":
		return "Take what?"
	
	for item in current_room.items:
		if second_word.to_lower() == item.item_name.to_lower():
			player.take_item(item)
			current_room.remove_item(item)
			return "You take the " + item.item_name
			
	return "There is no item like that in this room."


func drop(second_word: String) -> String:
	if second_word == " ":
		return "Drop what?"
	
	for item in player.inventory:
		if second_word.to_lower() == item.item_name.to_lower():
			player.drop_item(item)
			current_room.add_item(item)
			return "You drop the " + item.item_name
	
	return "There is no item like that in your inventory"

func inventory() -> String:
	return player.get_inventory_list()


func help() -> String:
	return "Commands: go[location], take[item], drop[item], inventory"


func change_room(new_room) -> String:
	current_room = new_room
	return new_room.get_full_description()
