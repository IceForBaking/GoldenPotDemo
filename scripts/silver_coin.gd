extends Node2D

@export var award_amount := 1

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		CollectibleManager.give_picup_award(award_amount)
		collision_shape.queue_free()
		
		var tween = get_tree().create_tween().set_parallel()
		tween.tween_property(animated_sprite, "position", Vector2(animated_sprite.position.x, animated_sprite.position.y - 15), 1).from_current()
		tween.tween_property(animated_sprite, "self_modulate:a", 0.0, 1)
		await tween.finished
		queue_free()
