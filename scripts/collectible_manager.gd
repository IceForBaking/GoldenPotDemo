extends Node

var start_coin_value: int = 0
var total_award_amount: int


signal on_cillectible_award_received

func give_picup_award(collectible_award : int): 
	total_award_amount += collectible_award
	
	on_cillectible_award_received.emit(total_award_amount)
