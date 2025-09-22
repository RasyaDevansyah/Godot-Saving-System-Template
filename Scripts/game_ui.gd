extends Control
class_name GameUI

@onready var label: Label = $Label
var score : int = 0

@onready var save_ui: Control = $"../SaveUI"


func _on_points_button_pressed() -> void:
	score += 100
	label.text = str(score).pad_zeros(9)
	pass # Replace with function body.


func _on_end_game_button_pressed() -> void:
	visible = false
	save_ui.visible = true
	pass # Replace with function body.
