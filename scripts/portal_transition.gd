extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var current_scene = get_tree().current_scene.scene_file_path
		var next_level_number = current_scene.to_int() + 1
		if next_level_number >= Globals.unlocked:
			Globals.unlocked = next_level_number
		get_tree().call_deferred("change_scene_to_file", "res://scenes/level_complete_screen.tscn")
		#get_tree().call_deferred("change_scene_to_file", "res://scenes/level's/test_level_" + str(next_level_number) + ".tscn")
	Globals.save_game()
		
