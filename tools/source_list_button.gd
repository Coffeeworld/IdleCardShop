extends OptionButton


# Called when the node enters the scene tree for the first time.
func _ready():
	for value in Card.Source:
		add_item(value)
