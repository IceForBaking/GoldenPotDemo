extends Control

@onready var star_1: TextureButton = $CompleteContainer/ScoreContainer/MoneyScore/StarContainer/Star1
@onready var star_2: TextureButton = $CompleteContainer/ScoreContainer/MoneyScore/StarContainer/Star2
@onready var star_3: TextureButton = $CompleteContainer/ScoreContainer/MoneyScore/StarContainer/Star3
@onready var money_label: Label = $CompleteContainer/ScoreContainer/MoneyScore/MarginContainer/MoneyLabel

func _ready() -> void:
	stars_result()
	money_result()
	
func stars_result():
	if CollectibleManager.total_award_amount <= 150:
		disable_all_stars()
		await get_tree().create_timer(1).timeout
		star_1.disabled = false
	elif CollectibleManager.total_award_amount <= 350:
		disable_all_stars()
		await get_tree().create_timer(1).timeout
		star_1.disabled = false
		await get_tree().create_timer(1).timeout
		star_2.disabled = false
	elif CollectibleManager.total_award_amount <= 570:
		disable_all_stars()
		await get_tree().create_timer(1).timeout
		star_1.disabled = false
		await get_tree().create_timer(1).timeout
		star_2.disabled = false
		await get_tree().create_timer(1).timeout
		star_3.disabled = false

func disable_all_stars():
	star_3.disabled = true
	star_2.disabled = true
	star_1.disabled = true
	

func money_result():
	money_label.text = str(CollectibleManager.total_award_amount)

func _on_next_button_pressed() -> void:
	CollectibleManager.total_award_amount = CollectibleManager.start_coin_value
	Events.location_changed.emit(Events.LOCATIONS.LEVELS)


func _on_home_button_pressed() -> void:
	Events.location_changed.emit(Events.LOCATIONS.MAIN_MENU)
