extends Control

@onready var scene_tree = get_tree()

func _on_play_button_pressed() -> void:
	Events.location_changed.emit(Events.LOCATIONS.LEVELS)

func _on_settings_button_pressed() -> void:
	Events.location_changed.emit(Events.LOCATIONS.SETTINGS)
