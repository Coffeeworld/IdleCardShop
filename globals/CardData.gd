extends Node

var card_data_file_path = "res://data/Cards.json"
var complete_card_dictionary = {}
var list_of_sets: Array[String]

func _ready():
	update_card_dictionary()
	print("Complete Card Dictionary")
	print("----------------------")
	for collection_name in complete_card_dictionary:
		list_of_sets.append(collection_name)
		for card_number in complete_card_dictionary[collection_name]:
			print(collection_name, ": ", card_number)
	print("----------------------")
	print("End of Complete Card Dictionary")
	print("List of sets: " + str(list_of_sets))

func update_card_dictionary():
	if FileAccess.file_exists(card_data_file_path):
		var file = FileAccess.open(card_data_file_path, FileAccess.READ)
		var parsed_file = JSON.parse_string(file.get_as_text())
		if parsed_file is Dictionary:
			complete_card_dictionary = parsed_file
			print("Complete Card Dictionary Successfully Loaded")
		else:
			print("Error parsing card data file")
	else:
		print("Card data file not found")

func get_card_data(card_set_name: String, card_id: String) -> Dictionary:
	var card_data = {}
	if card_set_name in complete_card_dictionary:
		print(card_id)
		if card_id in complete_card_dictionary[card_set_name]:
			card_data = complete_card_dictionary[card_set_name][card_id]
		else:
			print("Card id not found in card set")
	else:
		print("Card set not found")
	return card_data

func get_set_size(card_set_name: String) -> int:
	var card_set_size = 0
	if card_set_name in complete_card_dictionary:
		card_set_size = complete_card_dictionary[card_set_name].size()
		print("Set Size: " + str(card_set_size))
	else:
		print("Unable to return set size: card set not found")
	return card_set_size

func get_cards_in_set_of_type(card_set_name: String, card_type: String) -> Dictionary:
	var cards: Dictionary = {}
	if card_set_name in complete_card_dictionary:
		for card_id in complete_card_dictionary[card_set_name]:
			var card_data = complete_card_dictionary[card_set_name][card_id]
			if card_data != {}:
				if card_data["card_type"] == card_type:
					cards[card_id] = card_data
			else:
				print("Card data is null")
	return cards

func get_cards_in_set(card_set_name: String) -> Dictionary:
	var cards: Dictionary = {}
	if card_set_name in complete_card_dictionary:
		for card_id in complete_card_dictionary[card_set_name]:
			var card_data = complete_card_dictionary[card_set_name][card_id]
			if card_data != {}:
				cards[card_id] = card_data
			else:
				print("Card data is null")
	return cards
