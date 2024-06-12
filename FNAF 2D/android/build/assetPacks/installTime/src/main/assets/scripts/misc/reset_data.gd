extends Button

signal data_reset

func reset_data():
	StarRankingManager.earned_star(-1, false)
	BestTimeManager.set_time_in_s(-1)
	data_reset.emit()
