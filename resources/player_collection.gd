extends Resource
class_name PlayerCollection

@export var player_card_collection = []
@export var player_pack_collection = []
@export var player_box_collection = []

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

func addCardToCollection(card: Card):
	player_card_collection.append(card)

func addPackToCollection(pack: Pack):
	player_pack_collection.append(pack)

func addBoxToCollection(box: Box):
	player_box_collection.append(box)

func removeCardFromCollection(card: Card):
	player_card_collection.remove(card)

func removePackFromCollection(pack: Pack):
	player_pack_collection.remove(pack)

func removeBoxFromCollection(box: Box):
	player_box_collection.remove(box)
