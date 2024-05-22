extends Control
class_name CollectionDialogue

@onready var player_collection = GameManager.player_collection
var player_card_collection
var player_pack_collection
var player_box_collection

func _ready():
	player_card_collection = player_collection.getPlayerCollection()["card_collection"]
	player_pack_collection = player_collection.getPlayerCollection()["pack_collection"]
	player_box_collection = player_collection.getPlayerCollection()["box_collection"]
	
	# Load the collection
	load_collection()

func load_collection():
	# Load the card collection
	for card in player_card_collection:
		var card_instance = load("res://scenes/Card.tscn").instantiate()
		card_instance.set_card(card)
		$CardCollection.add_child(card_instance)

	# Load the pack collection
	for pack in player_pack_collection:
		var pack_instance = load("res://scenes/Pack.tscn").instantiate()
		pack_instance.set_pack(pack)
		$PackCollection.add_child(pack_instance)

	# Load the box collection
	for box in player_box_collection:
		var box_instance = load("res://scenes/Box.tscn").instantiate()
		box_instance.set_box(box)
		$BoxCollection.add_child(box_instance)
