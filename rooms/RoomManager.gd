extends Node


func _ready() -> void:
#	var key = Item.new()
#	key.initalise("key", Types.ItemTypes.KEY)
#	key.use_value = $ShedRoom
#	$HouseRoom.connect_exit_unlocked("east", $OutsideRoom)
#
#	$OutsideRoom.add_item(key)
#	$OutsideRoom.connect_exit_locked("north", $ShedRoom)
	
	# Murim game
	var key = load("res://items/Key.tres")
	key.use_value = $BedRoom
	var cake = load("res://items/Cake.tres")
	var spirit = load("res://npcs/spirit.tres")
	var guard = load("res://npcs/guard.tres")
	
	$TrainingRoom.add_npc(spirit)
	$TrainingRoom.connect_exit_unlocked("room", $BedRoom, "start")
	$BedRoom.add_item(key)
	$BedRoom.add_item(cake)
	
	$BedRoom.connect_exit_unlocked("east", $GateRoom)
	$GateRoom.add_npc(guard)
	$GateRoom.connect_exit_locked("woods", $Woods, "entrance")
	$GateRoom.connect_exit_unlocked("mountains", $Mountains, "entrance")



