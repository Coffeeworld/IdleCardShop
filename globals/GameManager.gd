extends Node

var player_collection : PlayerCollection
var game_name : String = 'default'

func _ready():
	player_collection = SaveManager.load_or_create_player_collection(game_name)
	print(player_collection)
	print(ProjectSettings.globalize_path("user://"))
	
	
func save_game():
	SaveManager.save_player_collection_as_resource(player_collection)
