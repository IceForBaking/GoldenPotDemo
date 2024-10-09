extends Node2D

@onready var button: AnimatedSprite2D = $Button
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var open = false

func _ready() -> void:
	button.play("up")
	animation_player.play("door_closed")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and open == false:
		button.play("down")
		animation_player.play("door_opened")
		open = true
		
		
