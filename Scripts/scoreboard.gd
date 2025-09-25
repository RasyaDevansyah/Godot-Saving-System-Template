extends PanelContainer

# The scene for a single row in the scoreboard (Name | Score)
const SCOREBOARD_ROW = preload("uid://c7otsbsq4kjie") 

@onready var v_box_container: VBoxContainer = $MarginContainer/Control/scrollContainer/VBoxContainer

# Call this function whenever you want to show or refresh the scoreboard.
func _ready() -> void:
	# 1. Clear out any old rows that are currently displayed.
	for child in v_box_container.get_children():
		child.queue_free()
	
	# 2. Get the up-to-date, sorted data from our global GScript.
	var scoreboard_data : Array = GlobalScript.get_scoreboard_data()
	scoreboard_data.sort_custom(sort_scoreboard_row)
	# 3. Loop through the data and create a UI instance for each entry.
	for row_data: Dictionary in scoreboard_data:
		var instance : ScoreboardRow = SCOREBOARD_ROW.instantiate()
		v_box_container.add_child(instance)
		
		# Set the row's text from the dictionary's values
		# (This assumes your ScoreboardRow script has a `set_row_from_dict` function)
		instance.set_row_from_dict(row_data)

func sort_scoreboard_row(a : Dictionary, b : Dictionary) -> bool:
	return a.get("score", 0) > b.get("score", 0)

#extends PanelContainer
#class_name Scoreboard
#
#@export var scoreboard : ScoreboardResource
#
#@onready var v_box_container: VBoxContainer = $MarginContainer/Control/scrollContainer/VBoxContainer
#const SCOREBOARD_ROW = preload("uid://c7otsbsq4kjie")
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#
	## Clear any old children first
	#for child in v_box_container.get_children():
		#child.queue_free()
#
	#scoreboard = GlobalScript.saveFile.scoreboardRes
	## --- ADD THIS LINE ---
	## Sort the array in-place based on the score, from highest to lowest.
	#scoreboard.scoreboardData.sort_custom(func(a, b): return a.score > b.score)
	## --------------------
	#
	## Now, create the instances from the sorted data
	#for row_data: ScoreboardRowResource in scoreboard.scoreboardData:
		#var instance : ScoreboardRow = SCOREBOARD_ROW.instantiate()
		#v_box_container.add_child(instance)
		#instance.set_row(row_data)
