extends Resource
class_name Card

@export_group("Core Identifiers")
@export var card_set_name: String = 'Test Set'
@export var number: int = 0

@export_group("Variable Instance Attributes")
@export var quality: Quality = Quality.AVERAGE
@export var surface_finish: SurfaceFinish = SurfaceFinish.STANDARD

@export_group("Derived Attributes")
@export var rarity: Rarity = Rarity.COMMON
@export var name: String = 'Card Name'
@export var flavor_text: String = 'Flavor Text'
@export var text: String = 'Card Text'
@export var type: Type = Type.CHARACTER
@export var subtypes: Array[String] = []
@export var image: CompressedTexture2D = null

enum Quality {
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
	STANDARD,
	FOIL
}

enum Rarity {
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

#TODO functions to get enums as strings and vice versa (use capitalize to make enum Camel)

func get_rarity_color(rarity: String) -> Color:
	var rarityIndex = Rarity[rarity]
	if rarityIndex != - 1:
		return RARITY_COLORS[rarityIndex]
	else:
		return Color(0, 0, 0) # Default color if rarity is not found

func generate_card(card_set_name: String, card_type: String) -> Card:
	var new_card = Card.new()
	new_card.card_set_name = card_set_name
	new_card.type = card_type
	var candidate_cards = CardData.get_cards_in_set_of_type(card_set_name, card_type)
	if candidate_cards.size() == 0:
		print("No cards found for set " + card_set_name + " and type " + card_type)
		return null
	var total_weight = get_total_weight_of_candidates(candidate_cards)
	var random_number = randi() % total_weight
	print(random_number)
	print("The following cards are candidates for generation:")
	var cumulative_weight = 0
	for card_key in candidate_cards:
		var card = candidate_cards[card_key]
		print("Current card: " + card.card_name)
		cumulative_weight += card.weight
		print("cumulative weight: " + str(cumulative_weight))
		if random_number <= cumulative_weight:
			print("Selected card: " + card.card_name)
			print(card)
			new_card.name = card.card_name
			new_card.flavor_text = card.flavor
			if card.has("text") and card.text:
				new_card.text = card.text
			if card.has("subtypes") and card.subtypes:
				print(card.subtypes)
				for subtype in new_card.subtypes:
					new_card.subtypes.append(subtype.strip())
			if card.has("image") and card.image:
				new_card.image = card.image
			new_card.rarity = card.rarity
			new_card.quality = randi() % Quality.size()
			if randf() < 0.07:
				new_card.surface_finish = SurfaceFinish.FOIL
			else:
				new_card.surface_finish = SurfaceFinish.STANDARD
			new_card.number = card_key
			GameManager.player_collection.add_card_to_collection(new_card)
			print(GameManager.player_collection.get_player_collection())
			#print(GameManager.player_collection.getPlayerCollection())
			break
	print("-------------------")
	return new_card

#TODO: Implement a function to generate a card based on a specific card key

func get_card_type_as_string(card: Card) -> String:
	return Type.keys()[card.type].capitalize()

func get_total_weight_of_candidates(candidate_cards: Dictionary) -> int:
	var total_weight = 0
	for card_key in candidate_cards:
		total_weight += candidate_cards[card_key].weight
	return total_weight
