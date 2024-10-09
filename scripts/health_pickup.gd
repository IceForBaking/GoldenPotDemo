extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $HelthPickupBox/CollisionShape2D

@export var picup_amount := 1

func _on_helth_pickup_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") && HealthManager.current_health != HealthManager.max_health:
		HealthManager.increase_health(picup_amount)
		collision_shape.queue_free()
	
		var tween = get_tree().create_tween()
		tween.tween_property(animated_sprite, "self_modulate:a", 0.0, 1).from_current()
		tween.tween_callback(queue_free)
