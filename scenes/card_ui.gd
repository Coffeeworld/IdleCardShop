extends Control

@export var card: Card

func set_card(card: Card):
	self.card = card
	update_card()

func update_card():
	print(card.name)
	%Name.text = card.name
	%Type.text = card.get_card_type_as_string(card)
	%Subtypes.text = str(card.keywords)
	%Set.text = card.card_set_name
	%Flavor.text = card.flavor_text
	%Text.text = card.text
	%RarityColor.set_color(Card.RARITY_COLORS[card.rarity])
	%Color.set_color(Card.SOURCE_COLORS[card.source])
	%Art.set_texture(card.art)
	if card.art_style == 1:
		%Type.hide()
		%Flavor.hide()
		%Text.hide()
		%Art.anchor_bottom = 0.9333
	if card.surface_finish == 1:
		%Foil.show()
