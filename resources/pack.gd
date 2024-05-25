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

func generate_pack():
	pass

func open_pack():
	pass
