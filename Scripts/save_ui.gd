extends Control
class_name SaveUI
@onready var game_ui: GameUI = $"../GameUI"
@onready var line_edit: LineEdit = $VBoxContainer/LineEdit


func _on_submit_button_pressed() -> void:
	var scoreBoardRow : ScoreboardRowResource = ScoreboardRowResource.new()
	scoreBoardRow.name = line_edit.text
	scoreBoardRow.score = game_ui.score
	
	GlobalScript.saveFile.scoreboardRes.scoreboardData.append(scoreBoardRow)
	GlobalScript.saveFile.WriteSaveGame()
	
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	pass # Replace with function body.
