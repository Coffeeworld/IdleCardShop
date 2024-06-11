extends Control
class_name CollectionDialogue

var player_collection: PlayerCollection
var player_card_collection
var player_pack_collection
var player_box_collection

func _ready():
	player_collection = GameManager.player_collection
	player_card_collection = player_collection.player_card_collection
	player_pack_collection = player_collection.player_pack_collection
	player_box_collection = player_collection.player_box_collection
