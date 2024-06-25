extends Resource
class_name Pack

@export var card_set_name: String
@export var pack_size: int
@export var pack_edition := PackEdition.STANDARD
@export var quality := Enums.Quality.AVERAGE
@export var art: CompressedTexture2D = null

enum PackEdition {
	RANDOM,
	STANDARD,
	FIRST_ED,
	GOD,
	COLLECTOR,
	MINI
}

func generate_pack(card_set_name: String, pack_edition: PackEdition=PackEdition.STANDARD, quality: Enums.Quality=Enums.Quality.AVERAGE):
	var new_pack = Pack.new()
	
	new_pack.card_set_name = card_set_name

	if quality == Enums.Quality.RANDOM:
		var random_quality = randf()
		if random_quality < 0.08:
			new_pack.quality = Enums.Quality.RAGGED
		elif random_quality < 0.20:
			new_pack.quality = Enums.Quality.POOR
		elif random_quality < 0.37:
			new_pack.quality = Enums.Quality.WORN
		elif random_quality < 0.62:
			new_pack.quality = Enums.Quality.AVERAGE
		elif random_quality < 0.79:
			new_pack.quality = Enums.Quality.GOOD
		elif random_quality < 0.91:
			new_pack.quality = Enums.Quality.FINE
		elif random_quality < 0.99:
			new_pack.quality = Enums.Quality.EXCELLENT
		else:
			new_pack.quality = Enums.Quality.MINT
	else:
		new_pack.quality = quality
	
	if pack_edition == PackEdition.RANDOM:
		var random_edition = randf()
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
	
	if pack_edition == PackEdition.MINI:
		new_pack.pack_size = 5
	else:
		new_pack.pack_size = 12
	
	GameManager.player_collection.add_pack_to_collection(new_pack)

func open_pack(pack: Pack) -> Array[Card]:
	var cards = []

	GameManager.player_collection.remove_pack_from_collection(pack)

	for i in range(pack.pack_size):

		var card = Card.new()
		card.generate_card(pack.card_set_name, pack.quality)
		cards.append(card)
		GameManager.player_collection.add_card_to_collection(card)
	
	return cards

# custom pack generation that takes an array of card ids
func custom_pack(cards: Array[int]):
	var new_pack = Pack.new()
	GameManager.player_collection.add_pack_to_collection(new_pack)
