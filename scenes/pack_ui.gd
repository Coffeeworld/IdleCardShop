extends Control

@export var pack : Pack

func set_pack(pack):
	self.pack = pack
	update_pack()

func update_pack():
	#print(pack.card_set_name)
	%Set.text = pack.card_set_name
	#%Art.set_texture = pack.art
