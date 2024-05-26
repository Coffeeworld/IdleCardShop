extends Resource
class_name Pack

@export var set_name : String
@export var pack_size : int
@export var pack_edition := PackEdition.STANDARD
@export var quality := Quality.AVERAGE
@export var art: CompressedTexture2D = null

enum PackEdition {
	STANDARD,
	FIRST_ED,
	GOD,
	COLLECTOR,
	MINI
}

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

func generate_pack(set_name : String, pack_edition : PackEdition):
	var new_pack = Pack.new()
	new_pack.set_name = set_name
	#new_pack.quality = 
	if pack_edition == PackEdition.MINI:
		new_pack.pack_size = 5
	else:
		new_pack.pack_size = 12
	GameManager.player_collection.add_pack_to_collection(new_pack)

func open_pack():
	pass

func custom_pack(cards : Array[Card]):
	pass
