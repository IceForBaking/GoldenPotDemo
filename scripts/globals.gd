extends Node

const location_to_scene = {
	Events.LOCATIONS.PLAY: preload("res://scenes/level's/test_level_1.tscn"),
	Events.LOCATIONS.LEVELS: preload("res://scenes/levels_menu.tscn"),
	Events.LOCATIONS.SETTINGS: preload("res://scenes/setting_menu.tscn"),
	Events.LOCATIONS.MAIN_MENU: preload("res://scenes/main_menu.tscn"),
}

const SAVE_GAME_PATH := "user://savegame.save"
const SAVE_VARIABLES := ["unlocked"] 

var levels = []
var unlocked = 1

func _ready() -> void:
	load_game()
	Events.location_changed.connect(handle_location_change)
	
func save_game():
	var save_game_file = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	var game_data := {}
	for variable in SAVE_VARIABLES:
		game_data[variable] = get(variable)
	var json_object := JSON.new()
	save_game_file.store_line(json_object.stringify(game_data)) 
	
func load_game():
	if not FileAccess.file_exists(SAVE_GAME_PATH):
		return
	var save_game_file = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
	var json_object := JSON.new()
	json_object.parse(save_game_file.get_line())
	var game_data = json_object.get_data()
	for variable in SAVE_VARIABLES:
		if variable in game_data:
			set(variable, game_data[variable])
	
func handle_location_change(location: Events.LOCATIONS):
	get_tree().change_scene_to_packed(location_to_scene.get(location))
