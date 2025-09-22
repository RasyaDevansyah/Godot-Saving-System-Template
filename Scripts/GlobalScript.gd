extends Node
class_name GScript


var saveFile : SaveFileResource = preload("uid://gn600tetrp45")

func _ready():
	# Attempt to load the save game
	var loadedSaveFile = SaveFileResource.LoadSaveGame()
	# Check if save file loaded successfully
	if loadedSaveFile == null:
		# If not, create a new save file
		print("Creating new save file...")
		saveFile.WriteSaveGame()
		
		
	else:
		# Save file loaded successfully
		print("Save file loaded successfully.")
		saveFile = loadedSaveFile
		
		
