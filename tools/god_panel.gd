extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_add_cards_to_collection_pressed():
	var new_card = Card.new().generate_card("Dustborn")

func _on_wipe_inventory_pressed():
	GameManager.player_collection.clear_collections()

func _on_add_specific_card_to_collection_pressed():
	var new_card = Card.new().generate_specific_card("Dustborn", %SpecifiedCard.text)

func _on_add_pack_to_collection_pressed():
	var new_pack = Pack.new().generate_pack("Dustborn")

func _on_generate_card_pressed():
	pass # Replace with function body.
