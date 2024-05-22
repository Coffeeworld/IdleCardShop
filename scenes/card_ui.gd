extends Control

@export var card: Card

func setCard(card: Card):
	self.card = card
	updateCard()

func updateCard():
	print(card)
	%Name.text = card.name
	%Type.text = card.getCardTypeAsString(card)
	%Subtypes.text = card.subtypes
	%Set.text = card.set
	%Flavor.text = card.flavor_text
	%Text.text = card.text
	%RarityColor.set_color(Card.RARITY_COLORS[card.rarity])
