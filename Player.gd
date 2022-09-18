extends Node
class_name Player


var inventory: Array = []


func take_item(item: Item):
	inventory.append(item)


func drop_item(item: Item):
	inventory.erase(item)


func get_inventory_list():
	if inventory.size() == 0:
		return "You have no items in your inventory"
	
	var inventory_string = "Inventory: "
	for item in inventory:
		inventory_string += item.item_name + " "
	
	return inventory_string
