extends Resource
class_name Pack

@export var card_set_name: String
@export var pack_size: int
@export var pack_edition := PackEdition.STANDARD
@export var quality := Quality.AVERAGE
@export var art: CompressedTexture2D = null

enum PackEdition {
	RANDOM,
	STANDARD,
	FIRST_ED,
	GOD,
	COLLECTOR,
	MINI
}

enum Quality {
	RANDOM,
	RAGGED,
	POOR,
	WORN,
	AVERAGE,
	GOOD,
	FINE,
	EXCELLENT,
	MINT
}

func generate_pack(card_set_name: String, pack_edition: PackEdition=PackEdition.STANDARD, quality: Quality=Quality.AVERAGE):
	var new_pack = Pack.new()
	
	new_pack.card_set_name = card_set_name

	var random_quality = randf()
	if quality == Quality.RANDOM:
		if random_quality < 0.08:
			new_pack.quality = Quality.RAGGED
		elif random_quality < 0.20:
			new_pack.quality = Quality.POOR
		elif random_quality < 0.37:
			new_pack.quality = Quality.WORN
		elif random_quality < 0.62:
			new_pack.quality = Quality.AVERAGE
		elif random_quality < 0.79:
			new_pack.quality = Quality.GOOD
		elif random_quality < 0.91:
			new_pack.quality = Quality.FINE
		elif random_quality < 0.99:
			new_pack.quality = Quality.EXCELLENT
		else:
			new_pack.quality = Quality.MINT
	else:
		new_pack.quality = quality
	
	var random_edition = randf()
	if pack_edition == PackEdition.RANDOM:
		if random_edition < 0.01:
			new_pack.pack_edition = PackEdition.FIRST_ED
		elif random_edition < 0.02:
			new_pack.pack_edition = PackEdition.GOD
		elif random_edition < 0.04:
			new_pack.pack_edition = PackEdition.COLLECTOR
		elif random_edition < 0.10:
			new_pack.pack_edition = PackEdition.MINI
		else:
			new_pack.pack_edition = PackEdition.STANDARD
	else:
		new_pack.pack_edition = pack_edition
	
	GameManager.player_collection.add_pack_to_collection(new_pack)

func open_pack(pack: Pack) -> Array[Card]:
	var cards = []

	GameManager.player_collection.remove_pack_from_collection(pack)
	return cards

# custom pack generation that takes an array of card ids
func custom_pack(cards: Array[int]):
	var new_pack = Pack.new()
	GameManager.player_collection.add_pack_to_collection(new_pack)
