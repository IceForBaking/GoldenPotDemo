extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var force := -600.0

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		area.get_parent().velocity.y = force
		animated_sprite.play("push_away")
		await animated_sprite.animation_finished
		animated_sprite.play("idle")
