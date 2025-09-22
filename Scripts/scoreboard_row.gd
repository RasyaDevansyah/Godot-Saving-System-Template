extends HBoxContainer
class_name ScoreboardRow

@onready var name_: Label = $PanelContainer/MarginContainer/Name
@onready var score: Label = $PanelContainer2/MarginContainer/Score


func set_row(res : ScoreboardRowResource):
	name_.text = str(res.name)
	score.text = str(res.score).pad_zeros(9)
	
	
	
	
