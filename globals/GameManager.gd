extends Node

var player_collection : PlayerCollection

func _ready():
	player_collection = PlayerCollection.new()
	print(player_collection)