extends Control



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.

@onready var menu_ui: VBoxContainer = $MenuUI
@onready var scoreboard: PanelContainer = $Scoreboard
@onready var settings: Control = $Settings

func _on_settings_pressed() -> void:
	menu_ui.visible = false
	scoreboard.visible = false
	settings.visible = true
