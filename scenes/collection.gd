extends VBoxContainer

@export var item_type: ItemTypes

var current_page_index = 0

enum ItemTypes {
	CARD,
	PACK,
	BOX
}

func _ready():
	refresh_ui()
	
	SignalManager.connect("update_collection_ui", refresh_ui)

func _on_previous_page_pressed():
	%NextPage.show()
	%ItemGrids.get_child(current_page_index).hide()
	current_page_index -= 1
	%ItemGrids.get_child(current_page_index).show()
	if current_page_index == 0:
		%PreviousPage.hide()

func _on_next_page_pressed():
	%PreviousPage.show()
	%ItemGrids.get_child(current_page_index).hide()
	current_page_index += 1
	%ItemGrids.get_child(current_page_index).show()
	if (current_page_index + 1) >= %ItemGrids.get_child_count():
		%NextPage.hide()

func _on_collection_selection_item_selected(index):
	if item_type == 0:
		var set_name = %CollectionSelection.get_item_text(index)
		var set_size = CardData.get_set_size(set_name)
		var num_grids = set_size / 16
		print("GRID COUNT" + str(num_grids))
		for i in range(num_grids):
			var grid = GridContainer.new()
			# Configure the grid container as needed
			grid.set_columns(8)
			%ItemGrids.add_child(grid)
			grid.hide()
			for c in range(16):
				var cardPanel = PanelContainer.new()
				# Configure the panel container as needed
				cardPanel.set_custom_minimum_size(Vector2(250, 350))
				var cardLabel = Label.new()
				cardLabel.set_text("Card " + str(i * 16 + c + 1))
				cardPanel.add_child(cardLabel)
				grid.add_child(cardPanel)
				var childCountLabel = Label.new()
				childCountLabel.set_text(str(cardPanel.get_child_count() - 1))
				cardPanel.add_child(childCountLabel)
				childCountLabel.hide()
		%ItemGrids.get_child(0).show()
		for card in GameManager.player_collection.player_card_collection:
			#print(card.name)
			var card_number = card.get_card_number()
			#print("Card Number: " + card_number)
			var card_panel = find_card_panel_by_number(card_number)
			#print(card_panel)
			if card_panel != null:
				var card_instance = load("res://scenes/Card.tscn").instantiate()
				card_instance.set_card(card)
				card_panel.add_child(card_instance)
				card_panel.get_child(1).set_text(str(card_panel.get_child_count()))
				card_panel.get_child(1).show()
				card_panel.get_child(0).hide()

func _on_variation_selection_item_selected(index):
	pass # Replace with function body.

func _on_show_missing_cards_toggled(toggled_on):
	pass # Replace with function body.

func find_card_panel_by_number(number: String) -> PanelContainer:
	for grid in %ItemGrids.get_children():
		for cardPanel in grid.get_children():
			if cardPanel.get_child(0).get_text() == "Card " + number:
				print("FOUND CARD PANEL")
				return cardPanel
	return null

func refresh_ui():
	for child in %ItemGrids.get_children():
		%ItemGrids.remove_child(child)
	for set_name in CardData.list_of_sets:
		%CollectionSelection.add_item(set_name)
		%CollectionSelection.select(0)
		_on_collection_selection_item_selected(0)
		%VariationSelection.select(0)
		if %ItemGrids.get_child_count() > 0:
			%NextPage.show()
