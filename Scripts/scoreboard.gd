extends PanelContainer
class_name Scoreboard

@export var scoreboard : ScoreboardResource

@onready var v_box_container: VBoxContainer = $MarginContainer/Control/scrollContainer/VBoxContainer
const SCOREBOARD_ROW = preload("uid://c7otsbsq4kjie")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Clear any old children first
	for child in v_box_container.get_children():
		child.queue_free()

	scoreboard = GlobalScript.saveFile.scoreboardRes
	# --- ADD THIS LINE ---
	# Sort the array in-place based on the score, from highest to lowest.
	scoreboard.scoreboardData.sort_custom(func(a, b): return a.score > b.score)
	# --------------------
	
	# Now, create the instances from the sorted data
	for row_data: ScoreboardRowResource in scoreboard.scoreboardData:
		var instance : ScoreboardRow = SCOREBOARD_ROW.instantiate()
		v_box_container.add_child(instance)
		instance.set_row(row_data)
