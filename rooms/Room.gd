tool
extends PanelContainer
class_name Roomz


export (String) var room_name = "Room Name" setget set_room_name
export (String, MULTILINE) var room_description = "This is the description of the room" setget set_room_description

var exits: Dictionary = {}
var items: Array = []


func set_room_name(new_name: String):
	$MarginContainer/Rows/RoomName.text = new_name
	room_name = new_name


func set_room_description(new_desc: String):
	$MarginContainer/Rows/RoomDescription.text = new_desc
	room_description = new_desc


func add_item(item: Item):
	items.append(item)


func remove_item(item: Item):
	items.erase(item)


func get_full_description() -> String:
	var full_description = PoolStringArray([
		get_room_description(),
		get_item_description(),
		get_exit_description()
	]).join("\n")
	return full_description


func get_room_description() -> String:
	return "You are now in: " + room_name + ". It is " + room_description


func get_item_description() -> String:
	if items.size() == 0:
		return "No items to pick up."
	
	var item_string = ""
	for item in items:
		item_string += item.item_name + " "
	return "Items: " + item_string


func get_exit_description() -> String:
	return "Exits: " + PoolStringArray(exits.keys()).join(" ")


func connect_exit_unlocked(direction: String, room, room_2_override = "null"):
	return _connect_exit(direction, room, false, room_2_override)

func connect_exit_locked(direction: String, room, room_2_override = "null"):
	return _connect_exit(direction, room, true, room_2_override)


func _connect_exit(direction: String, room, is_locked: bool = false, room_2_override = "null"):
	var exit = Exit.new()
	exit.room_1 = self
	exit.room_2 = room
	exit.is_locked = is_locked
	exits[direction] = exit
	
	if room_2_override != "null":
		room.exits[room_2_override] = exit
	else:
		match direction:
			"west":
				room.exits["east"] = exit
			"east":
				room.exits["west"] = exit
			"north":
				room.exits["south"] = exit
			"south":
				room.exits["north"] = exit
			"inside":
				room.exits["outside"] = exit
			"outside":
				room.exits["inside"] = exit
			"smallroom":
				room.exits["north"] = exit
			_:
				printerr("Tried to connect to an invalid directions %s", direction)
	
	return exit


