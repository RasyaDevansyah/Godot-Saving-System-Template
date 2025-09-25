extends Node
class_name GScript


var safeFile : EncryptedSaveFileResource = EncryptedSaveFileResource.new()

func _ready() -> void:
	if !safeFile.LoadSaveGame():
		var newData : Dictionary = {
			"scoreboardData" = [
				{
					"name" : "Gigachad",
					"score" : 100
				}
				
			]
		}
		
		print("creating new safe file")
		safeFile.set_data(newData)
		safeFile.WriteSaveGame()
		

func get_scoreboard_data() -> Array:
	return safeFile.data.get("scoreboardData", null)
	

#var saveFile : SaveFileResource = preload("uid://gn600tetrp45")

#func _ready():
	## Attempt to load the save game
	#var loadedSaveFile = SaveFileResource.LoadSaveGame()
	## Check if save file loaded successfully
	#if loadedSaveFile == null:
		## If not, create a new save file
		#print("Creating new save file...")
		#saveFile.WriteSaveGame()
	#else:
		## Save file loaded successfully
		#print("Save file loaded successfully.")
		#saveFile = loadedSaveFile
		#
		#
