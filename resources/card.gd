extends Resource
class_name Card

@export_group("Core Identifiers")
@export var set: String = 'Test Set'
@export var number: int = 0

@export_group("Variable Instance Attributes")
@export var quality: Quality = Quality.RAGGED
@export var surface_finish: SurfaceFinish = SurfaceFinish.STANDARD

@export_group("Derived Attributes")
@export var rarity: Rarity = Rarity.COMMON
@export var name: String = 'Card Name'
@export var flavor_text: String = 'Flavor Text'
@export var text: String = 'Card Text'
@export var type: Type = Type.CHARACTER
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
	SPECIAL
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
	Color.CYAN
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

func getRarityColor(rarity: String) -> Color:
	var rarityIndex = Rarity[rarity]
	if rarityIndex != - 1:
		return RARITY_COLORS[rarityIndex]
	else:
		return Color(0, 0, 0) # Default color if rarity is not found

func generateCard(set_name: String, card_type: String) -> Card:
	var newCard = Card.new()
	newCard.set = set_name
	newCard.type = card_type
	var candidate_cards = CardData.getCardsInSetOfType(set_name, card_type)
	print("The following cards are candidates for generation:")
	for card in candidate_cards:
		print(card.name)
	print("-------------------")
	var totalCandidateWeight = 0
	for card in candidate_cards:
		totalCandidateWeight += card.weight
	return newCard