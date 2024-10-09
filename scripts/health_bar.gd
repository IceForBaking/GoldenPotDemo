extends Node2D

@export var first_heart : Texture2D
@export var second_heart : Texture2D

@onready var heart_1: Sprite2D = $Heart1
@onready var heart_2: Sprite2D = $Heart2
@onready var heart_3: Sprite2D = $Heart3

func _ready() -> void:
	HealthManager.on_health_changed.connect(on_player_health_changed)
	
func on_player_health_changed(player_current_health: int):
	if player_current_health == 3:
		heart_3.texture = first_heart
	elif player_current_health < 3:
		heart_3.texture = second_heart
		
	if player_current_health == 2:
		heart_2.texture = first_heart
	elif player_current_health < 2:
		heart_2.texture = second_heart
		
	if player_current_health == 1:
		heart_1.texture = first_heart
	elif player_current_health < 1:
		heart_1.texture = second_heart
