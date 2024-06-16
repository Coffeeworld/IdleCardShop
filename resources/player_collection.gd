extends Resource
class_name PlayerCollection

@export var game_name: String
@export var player_card_collection = []
@export var player_pack_collection = []
@export var player_box_collection = []

func clear_collections():
	player_card_collection.clear()
	player_pack_collection.clear()
	player_box_collection.clear()
	SignalManager.emit_signal("reset_collection")
	SaveManager.save_player_collection_as_resource(GameManager.player_collection)

func get_player_collection() -> Dictionary:
	return {
		"card_collection": player_card_collection,
		"pack_collection": player_pack_collection,
		"box_collection": player_box_collection
	}

func add_card_to_collection(card: Card):
	player_card_collection.append(card)
	SignalManager.emit_signal("card_added_to_collection", card)

func add_pack_to_collection(pack: Pack):
	player_pack_collection.append(pack)
	SignalManager.emit_signal("pack_added_to_collection", pack)

func add_box_to_collection(box: Box):
	player_box_collection.append(box)
	SignalManager.emit_signal("box_added_to_collection", box)

func remove_card_from_collection(card: Card):
	player_card_collection.remove(card)
	SignalManager.emit_signal("card_removed_from_collection", card)

func remove_pack_from_collection(pack: Pack):
	player_pack_collection.remove(pack)
	SignalManager.emit_signal("pack_removed_from_collection", pack)

func remove_box_from_collection(box: Box):
	player_box_collection.remove(box)
	SignalManager.emit_signal("box_removed_from_collection", box)
