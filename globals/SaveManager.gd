extends Node

var save_file_path = "user://save/"
var game_file_name: String

func _ready():
	pass
	
func save_player_collection_as_resource(player_collection: PlayerCollection):
	game_file_name = player_collection.game_name
	ResourceSaver.save(player_collection, save_file_path + game_file_name + ".tres")

func load_or_create_player_collection(game_name: String) -> PlayerCollection:
	game_file_name = game_name
	var player_collection = ResourceLoader.load(save_file_path + game_file_name + ".tres")
	if player_collection == null:
		player_collection = PlayerCollection.new()
		player_collection.game_name = game_name
		ResourceSaver.save(player_collection, save_file_path + game_file_name + ".tres")
	print(player_collection.get_player_collection())
	return player_collection
