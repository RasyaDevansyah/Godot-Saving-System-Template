extends HBoxContainer
class_name ScoreboardRow

@onready var name_: Label = $PanelContainer/MarginContainer/Name
@onready var score: Label = $PanelContainer2/MarginContainer/Score


func set_row(res : ScoreboardRowResource):
	name_.text = str(res.name)
	score.text = str(res.score).pad_zeros(9)
	
func set_row_from_dict(data: Dictionary):
	name_.text = data.get("name", "N/A")
	score.text = str(int(data.get("score", 0))).pad_zeros(9)
	
