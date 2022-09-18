extends PanelContainer
class_name Roomz


export (String) var room_name = "Room Name"
export (String) var room_description = "This is the description of the room"

func _ready() -> void:
	$MarginContainer/Rows/RoomName.text = room_name
	$MarginContainer/Rows/RoomDescription.text = room_description
