extends Control

func _ready() -> void:
	for i in range(%LevelGrid.get_child_count()):
		Globals.levels.append(i+1)
	for level in %LevelGrid.get_children():
		if str_to_var(level.name) in range(Globals.unlocked + 1):
			level.disabled = false
			level.pressed.connect(self.change_level.bind(level.name))
		else:
			level.disabled = true
			level.text = ""

			
func change_level(lvl_no):
	get_tree().change_scene_to_file("res://scenes/level's/test_level_" + lvl_no + ".tscn")

func _on_home_button_pressed() -> void:
	Events.location_changed.emit(Events.LOCATIONS.MAIN_MENU)
