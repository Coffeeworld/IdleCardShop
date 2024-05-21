extends Node

var card_data_file_path = "res://data/Cards.json"
var complete_card_dictionary = {}

func _ready():
	updateCardDictionary()
	print("Complete Card Dictionary")
	print("----------------------")
	print(complete_card_dictionary)
	print("----------------------")
	print("End of Complete Card Dictionary")

func updateCardDictionary():
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

func getCardData(card_set: String, card_number: int) -> Dictionary:
	var card_data = {}
	if card_set in complete_card_dictionary:
		if card_number in complete_card_dictionary[card_set]:
			card_data = complete_card_dictionary[card_set][card_number]
		else:
			print("Card number not found in card set")
	else:
		print("Card set not found")
	return card_data

func getSetSize(card_set: String) -> int:
	var set_size = 0
	if card_set in complete_card_dictionary:
		set_size = complete_card_dictionary[card_set].size()
		print("Set Size: " + str(set_size))
	else:
		print("Unable to return set size: card set not found")
	return set_size

func getCardsInSetOfType(card_set: String, card_type: String) -> Dictionary:
	var cards: Dictionary = {}
	if card_set in complete_card_dictionary:
		for card_number in complete_card_dictionary[card_set]:
			var card_data = complete_card_dictionary[card_set][card_number]
			if card_data["type"] == card_type:
				cards[card_number] = (card_data)
			else:
				print("Unable to locate cards in set " + card_set + " of type " + card_type)
	return cards