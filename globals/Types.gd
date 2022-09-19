extends Node


enum ItemTypes {
	KEY,
	FOOD,
}

const COLOUR_NPC = Color("#ff9a94")
const COLOUR_ITEM = Color("94b9ff")
const COLOUR_SPEECH = Color("c3ff94")
const COLOUR_LOCATION = Color("faff94")
const COLOUR_SYSTEM = Color("ffd394")


func wrap_text(text: String, colour) -> String:
	return "[color=#%s]%s[/color]" % [colour.to_html(), text]
