extends Control
class_name CollectionDialogue

var player_collection : PlayerCollection
var player_card_collection
var player_pack_collection
var player_box_collection

func _ready():
	player_collection = GameManager.player_collection
	player_card_collection = player_collection.player_card_collection
	player_pack_collection = player_collection.player_pack_collection
	player_box_collection = player_collection.player_box_collection
	
	# Set the number of columns
	var num_columns = get_viewport_rect().size.x / 260
	
	SignalManager.update_collection_ui.connect(load_collection)

	# Load the collection
	load_collection()

func load_collection():
	clean_collection_ui()
	
	# Load the card collection
	for card in player_card_collection:
		var card_instance = load("res://scenes/Card.tscn").instantiate()
		card_instance.set_card(card)
		%CardCollection.add_child(card_instance)

	# Load the pack collection
	for pack in player_pack_collection:
		var pack_instance = load("res://scenes/Pack.tscn").instantiate()
		pack_instance.set_pack(pack)
		%PackCollection.add_child(pack_instance)

	# Load the box collection
	for box in player_box_collection:
		var box_instance = load("res://scenes/Box.tscn").instantiate()
		box_instance.set_box(box)
		%BoxCollection.add_child(box_instance)

func clean_collection_ui():
	for n in %CardCollection.get_children():
		%CardCollection.remove_child(n)
		n.queue_free()
	for n in %PackCollection.get_children():
		%PackCollection.remove_child(n)
		n.queue_free()
	for n in %BoxCollection.get_children():
		%BoxCollection.remove_child(n)
		n.queue_free()
