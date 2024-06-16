extends OptionButton

# Called when the node enters the scene tree for the first time.
func _ready():
	for set in CardData.list_of_sets:
		self.add_item(set)
