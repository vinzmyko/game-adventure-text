extends Resource
class_name NPC


export (String) var npc_name = "NPC Name"

export (String, MULTILINE) var initial_dialogue
export (String, MULTILINE) var post_quest_dialogue
export (Resource) var quest_item 
var has_quest_item_received := false 
