tool
extends PanelContainer
class_name Roomz


export (String) var room_name = "Room Name" setget set_room_name
export (String, MULTILINE) var room_description = "This is the description of the room" setget set_room_description

var exits: Dictionary = {}


func set_room_name(new_name: String):
	$MarginContainer/Rows/RoomName.text = new_name
	room_name = new_name


func set_room_description(new_desc: String):
	$MarginContainer/Rows/RoomDescription.text = new_desc
	room_description = new_desc


func connect_exit(direction: String, room):
	var exit = Exit.new()
	exit.room_1 = self
	exit.room_2 = room
	exits[direction] = exit
	match direction:
		"west":
			room.exits["east"] = exit
		"east":
			room.exits["west"] = exit
		"north":
			room.exits["south"] = exit
		"south":
			room.exits["north"] = exit
		_:
			printerr("Tried to connect to an invalid directions %s", direction)


