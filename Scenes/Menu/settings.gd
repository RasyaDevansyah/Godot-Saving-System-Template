extends Control

@onready var music_slider: HSlider = $VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/MusicSlider
@onready var sound_slider: HSlider = $VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/SoundSlider
@onready var screen_shake_check_box: CheckBox = $VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer3/ScreenShakeCheckBox



func _ready() -> void:
	visible = false
	updateUI()
	music_slider.connect("value_changed", _on_music_slider_changed)
	sound_slider.connect("value_changed", _on_sound_slider_changed)
	screen_shake_check_box.connect("pressed", _on_screen_shake_check_box)

func updateUI():
	music_slider.value = GlobalScript.playerPrefs.music
	sound_slider.value = GlobalScript.playerPrefs.sound
	screen_shake_check_box.button_pressed = GlobalScript.playerPrefs.cameraShake
	pass

func _on_music_slider_changed(value : float) -> void:
	GlobalScript.playerPrefs.music = value
	GlobalScript.playerPrefs.WriteSaveGame()

func _on_sound_slider_changed(value : float) -> void:
	GlobalScript.playerPrefs.sound = value
	GlobalScript.playerPrefs.WriteSaveGame()

func _on_screen_shake_check_box() -> void:
	GlobalScript.playerPrefs.cameraShake = screen_shake_check_box.button_pressed
	GlobalScript.playerPrefs.WriteSaveGame()

@onready var menu_ui: VBoxContainer = $"../MenuUI"
@onready var scoreboard: PanelContainer = $"../Scoreboard"

func _on_button_pressed() -> void:
	visible = false
	menu_ui.visible = true
	scoreboard.visible = true
