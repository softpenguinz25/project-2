extends Button

signal data_reset

func reset_data():
	StarRankingManager.earned_star(0)
	data_reset.emit()
