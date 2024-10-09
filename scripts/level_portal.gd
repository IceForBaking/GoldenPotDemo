extends Area2D

@onready var distnation_point: Marker2D = $Distnation_point

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.set_position(distnation_point.global_position)
		
