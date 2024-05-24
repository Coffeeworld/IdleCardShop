extends Node

var player_collection : PlayerCollection
var game_name : String = 'default'

func _ready():
	player_collection = SaveManager.loadOrCreatePlayerCollection(game_name)
	print(player_collection)
	print(ProjectSettings.globalize_path("user://"))
	
	
func saveGame():
	SaveManager.savePlayerCollectionAsResource(player_collection)
