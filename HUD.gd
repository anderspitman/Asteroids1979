extends CanvasLayer

func _on_Main_score_updated(score):
	$ScoreLabel.text = str(score)
