extends Node

var player_collection_dict = {}
var player_collection = PlayerCollection.new()

func _ready():
	player_collection_dict = player_collection.getPlayerCollection()
