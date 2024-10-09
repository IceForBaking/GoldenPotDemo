extends StaticBody2D

@onready var animation_tree = $AnimationTree.get("parameters/playback")

func _on_player_detected_body_entered(body: Node2D) -> void:
	if body.is_on_floor():
		animation_tree.travel("Regenerate")

func back_to_static():
	animation_tree.travel("Static")
