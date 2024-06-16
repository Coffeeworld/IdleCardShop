extends Resource
class_name Card

@export_group("Core Identifiers")
@export var card_set_name: String = 'Test Set'
@export var number: int = 0
@export var card_id: int = 0

@export_group("Variable Instance Attributes")
@export var quality: Quality = Quality.AVERAGE
@export var surface_finish: SurfaceFinish = SurfaceFinish.STANDARD

@export_group("Derived Attributes")
@export var art_style: Art_Style = Art_Style.STANDARD
@export var source: Source = Source.NEUTRAL
@export var rarity: Rarity = Rarity.MAGIC
@export var name: String = ''
@export var flavor_text: String = ''
@export var text: String = ''
@export var type: Type = Type.CHARACTER
@export var keywords: String
@export var art: CompressedTexture2D = null

@export_group("Source Color")
@export var source_color: Color

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

enum SurfaceFinish {
	RANDOM,
	STANDARD,
	FOIL
}

enum Rarity {
	RANDOM,
	COMMON,
	UNCOMMON,
	MAGIC,
	RARE,
	EPIC,
	LEGENDARY,
	MYTHIC,
	UNIQUE,
	SPECIAL,
	MASTERPIECE
}

static var RARITY_COLORS: Array[Color] = [
	Color.GRAY,
	Color.GRAY,
	Color.LIME_GREEN,
	Color.BLUE,
	Color.YELLOW,
	Color.PURPLE,
	Color.ORANGE,
	Color.RED,
	Color.PINK,
	Color.CYAN,
	Color.WEB_MAROON
]

enum Type {
	RANDOM,
	SOURCE,
	TOKEN,
	CHARACTER,
	DISCOVERY,
	ITEM,
	MERCENARY,
	SPELL,
	ABILITY,
	SPIRIT,
	LOCATION,
	EVENT,
	QUEST
}

enum Art_Style {
	RANDOM,
	STANDARD,
	FULL_ART
}

enum Source {
	RANDOM,
	CELESTIAL,
	BEGINNING,
	LIFE,
	LIGHT,
	HARMONY,
	END,
	DEATH,
	DARK,
	CHAOS,
	TEMPORAL,
	BALANCE,
	FATE,
	TWILIGHT,
	NEUTRAL
}

static var SOURCE_COLORS: Array[Color] = [
	Color.WHITE,
	Color.LIGHT_CYAN,
	Color.LIGHT_PINK,
	Color.FOREST_GREEN,
	Color.PALE_GOLDENROD,
	Color.LIGHT_SKY_BLUE,
	Color.MIDNIGHT_BLUE,
	Color.DARK_RED,
	Color.BLACK,
	Color.DARK_ORANGE,
	Color.WHITE,
	Color.WHITE,
	Color.WHITE,
	Color.WHITE,
	Color.SILVER
]

func get_card_type_as_string(card: Card) -> String:
	return Type.keys()[card.type].capitalize()

func get_total_weight_of_candidates(candidate_cards: Dictionary) -> int:
	var total_weight = 0
	for card_key in candidate_cards:
		total_weight += candidate_cards[card_key].weight
	return total_weight

func generate_card(card_set_name: String, quality:=Quality.RANDOM, surface:=SurfaceFinish.RANDOM, type:=Type.RANDOM, rarity:=Rarity.RANDOM, art_style:=Art_Style.RANDOM, source:=Source.RANDOM) -> Card:
	var candidate_cards = CardData.get_cards(card_set_name, type, rarity, art_style)
	#print(candidate_cards)
	var selected_card = select_card_from_candidates(candidate_cards)
	#print(selected_card)
	var new_card = Card.new()

	new_card.card_id = selected_card.card_key
	new_card.card_set_name = card_set_name
	if quality == Quality.RANDOM:
		new_card.quality = randi() % Quality.size()
	else:
		new_card.quality = quality
	if surface == SurfaceFinish.RANDOM:
		if randf() < 0.07:
			new_card.surface_finish = SurfaceFinish.FOIL
		else:
			new_card.surface_finish = SurfaceFinish.STANDARD
	else:
		new_card.surface_finish = surface
	new_card.rarity = Rarity.get(selected_card.rarity.to_upper())
	new_card.source = Source.get(selected_card.source.to_upper())
	new_card.art_style = Art_Style.get(selected_card.art_style.to_upper())
	#print("New Card Art Style: " + str(new_card.art_style))
	new_card.type = selected_card.card_type
	new_card.keywords = selected_card.keywords
	new_card.name = selected_card.card_name
	new_card.flavor_text = selected_card.flavor
	new_card.number = selected_card.card_number
	if selected_card.has("text") and selected_card.text:
		new_card.text = selected_card.text
	if selected_card.has("art") and selected_card.art:
		var texture_reference = load(selected_card.art)
		new_card.art = texture_reference
	print(new_card.name)
	GameManager.player_collection.add_card_to_collection(new_card)
	return new_card

func generate_specific_card(card_set_name: String, card_id: String) -> Card:
	var new_card = Card.new()
	var card_data = CardData.get_card_data(card_set_name, card_id)
	print(card_data)
	print(card_data['card_name'])
	new_card.card_set_name = card_set_name
	new_card.quality = randi() % Quality.size()
	if randf() < 0.07:
		new_card.surface_finish = SurfaceFinish.FOIL
	else:
		new_card.surface_finish = SurfaceFinish.STANDARD
	new_card.rarity = Rarity.get(card_data.rarity.to_upper())
	new_card.source = Source.get(card_data.source.to_upper())
	new_card.art_style = Art_Style.get(card_data.art_style.to_upper())
	print("New Card Art Style: " + str(new_card.art_style))
	new_card.type = card_data.card_type
	new_card.keywords = card_data.keywords
	new_card.name = card_data.card_name
	new_card.flavor_text = card_data.flavor
	if card_data.has("text") and card_data.text:
		new_card.text = card_data.text
	if card_data.has("art") and card_data.art:
		var texture_reference = load(card_data.art)
		new_card.art = texture_reference
	GameManager.player_collection.add_card_to_collection(new_card)
	return new_card

func select_card_from_candidates(candidate_cards: Dictionary) -> Dictionary:
	var total_weight = get_total_weight_of_candidates(candidate_cards)
	print('Total Candidate Card Weight: ' + str(total_weight))
	var random_number = randi() % total_weight
	print(random_number)
	#print("The following cards are candidates for generation:")
	var cumulative_weight = 0
	for card_key in candidate_cards:
		var card = candidate_cards[card_key]
		#print("Current card: " + card.card_name)
		cumulative_weight += card.weight
		#print("cumulative weight: " + str(cumulative_weight))
		if random_number <= cumulative_weight:
			print("Selected card: " + card.card_name)
			print(card)
			print("Card Key: " + card_key)
			card["card_key"] = card_key
			return card
	print("-------------------")
	return {}

func get_card_number() -> String:
	return str(number)
