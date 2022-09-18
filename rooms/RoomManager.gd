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
	var key = Item.new()
	key.initalise("key", Types.ItemTypes.KEY)
	
	$TrainingRoom.connect_exit_locked("room", $BedRoom, "start")
	$BedRoom.add_item(key)
	
	
	$BedRoom.connect_exit_locked("east", $GateRoom)
	$GateRoom.connect_exit_unlocked("woods", $Woods, "entrance")
	$GateRoom.connect_exit_unlocked("mountains", $Mountains, "entrance")



