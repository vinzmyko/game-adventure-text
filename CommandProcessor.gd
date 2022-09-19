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
		"use":
			return use(second_word)
		"talk":
			return talk(second_word)
		"give":
			return give(second_word)
		"help":
			return help()
		_:
			return Types.wrap_text("Unrecognised command - please try again", Types.COLOUR_SYSTEM)


func go(second_word: String) -> String:
	if second_word == " ":
		return Types.wrap_text("Go where?", Types.COLOUR_SYSTEM)
	
	if current_room.exits.keys().has(second_word):
		var exit = current_room.exits[second_word]
		if exit.is_locked:
			return "The way " + Types.wrap_text(second_word, Types.COLOUR_LOCATION) + " is currently " + Types.wrap_text("locked", Types.COLOUR_SYSTEM)
		var change_response = change_room(exit.get_other_room(current_room))
		return PoolStringArray(["You go %s." % second_word, change_response]).join("\n")
	else:
		return "This room has no exits in that direction"


func take(second_word: String) -> String:
	if second_word == " ":
		return Types.wrap_text("Take what?", Types.COLOUR_SYSTEM)
	
	for item in current_room.items:
		if second_word.to_lower() == item.item_name.to_lower():
			player.take_item(item)
			current_room.remove_item(item)
			return "You take the " + item.item_name
			
	return "There is no item like that in this room."


func drop(second_word: String) -> String:
	if second_word == " ":
		return Types.wrap_text("Drop what?", Types.COLOUR_SYSTEM)
	
	for item in player.inventory:
		if second_word.to_lower() == item.item_name.to_lower():
			player.drop_item(item)
			current_room.add_item(item)
			return "You drop the " + item.item_name
	
	return "There is no item like that in your inventory"

func inventory() -> String:
	return player.get_inventory_list()


func use(second_word: String) -> String:
	if second_word == " ":
		return Types.wrap_text("Use what?", Types.COLOUR_SYSTEM)
	
	for item in player.inventory:
		if second_word.to_lower() == item.item_name.to_lower():
			match item.item_type:
				Types.ItemTypes.KEY:
					for exit in current_room.exits.values():
						if exit == item.use_value:
							exit.is_locked = false
							player.drop_item(item)
							return "You use %s to unlock the door." % item.item_name
					return "That item does not unlock any doors in this room."
				_:
					return "Error - tried to use an item with an invalid type."
	
	return "You don't have that item."


func talk(second_word: String) -> String:
	if second_word == " ":
		return Types.wrap_text("Talk to who?", Types.COLOUR_SYSTEM)
	
	for npc in current_room.npcs:
		if npc.npc_name.to_lower() == second_word:
			var dialogue = npc.post_quest_dialogue if npc.has_quest_item_received else npc.initial_dialogue
			return npc.npc_name + ": \"" + dialogue + "\""
	
	return "That person doesn't now exist"


func give(second_word: String) -> String:
	if second_word == " ":
		return Types.wrap_text("Give what?", Types.COLOUR_SYSTEM)
	
	var has_item = false
	for item in player.inventory:
		if second_word.to_lower() == item.item_name.to_lower():
			has_item = true
	
	if !has_item:
		return "You don't have that item."
	
	for npc in current_room.npcs:
		if npc.quest_item != null and second_word.to_lower() == npc.quest_item.item_name.to_lower():
			npc.has_quest_item_received = true
			player.drop_item(second_word)
			return "You give the %s to the %s\n" % [second_word, npc.npc_name]
	
	return "Item cannot be given"



func help() -> String:
	return "Commands: go[location], take[item], drop[item], inventory, use[item], talk[npc], give[item]"


func change_room(new_room) -> String:
	current_room = new_room
	return new_room.get_full_description()
