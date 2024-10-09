extends Node

@onready var pause_menu: Control = $"../CanvasLayer/PauseMenu"
@onready var player_animated_sprite: AnimatedSprite2D = $"../Player/AnimatedSprite2D"

var game_paused:bool = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		game_paused = !game_paused
		
	if game_paused == true:
		get_tree().paused = true
		pause_menu.show()
	else:
		get_tree().paused = false
		pause_menu.hide()	
	
func _on_restart_button_pressed() -> void:
	HealthManager.current_health = HealthManager.max_health
	CollectibleManager.total_award_amount = CollectibleManager.start_coin_value
	get_tree().reload_current_scene()
	
func _on_resume_button_pressed() -> void:
	game_paused = !game_paused

func _on_home_button_pressed() -> void:
	HealthManager.current_health = HealthManager.max_health
	CollectibleManager.total_award_amount = CollectibleManager.start_coin_value
	get_tree().paused = false
	Events.location_changed.emit(Events.LOCATIONS.MAIN_MENU)

func _on_pause_button_pressed() -> void:
	game_paused = !game_paused
