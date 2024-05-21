extends Node

var save_file_path = "user://save/"
var game_file_name: String

func _ready():
	verify_save_directory(save_file_path)
	SignalManager.save_requested.connect(save)

func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)

func get_all_save_files():
	return DirAccess.open(save_file_path).get_files()

func save_game(save_name):
	var save_file = save_name + ".tres"
	var save_game_file = FileAccess.open(save_file_path + save_file, FileAccess.WRITE)
	
