extends RigidBody2D

@onready var round_stone: RigidBody2D = $"."


@export var damage := 1
@export var impulse := Vector2(-200, 0)

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		round_stone.linear_velocity = impulse
		
