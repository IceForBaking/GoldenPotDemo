extends CanvasLayer


@onready var collectible_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/CollectibleLabel

func _ready() -> void:
	CollectibleManager.on_cillectible_award_received.connect(on_cillectible_award_received)
	
func on_cillectible_award_received(total_award : int):
	collectible_label.text = str(total_award)
	
