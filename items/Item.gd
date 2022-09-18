extends Resource
class_name Item

export (String) var item_name := "Item Name"
export (Types.ItemTypes) var item_type := Types.ItemTypes.KEY


func initalise(name: String, type: int):
	item_name = name
	item_type = type