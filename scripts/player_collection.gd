extends Node
class_name PlayerCollection

var player_card_collection = {}
var player_pack_collection = {}
var player_box_collection = {}

func clearCollections():
	player_card_collection.clear()
	player_pack_collection.clear()
	player_box_collection.clear()

func getPlayerCollection() -> Dictionary:
	return {
		"card_collection": player_card_collection,
		"pack_collection": player_pack_collection,
		"box_collection": player_box_collection
	}
