extends Node
class_name GScript


var safeFile : EncryptedSaveFileResource = EncryptedSaveFileResource.new()
var playerPrefs : SaveFileResource

func _ready() -> void:
	loadEncryptedSave()
	

func loadPlayerPrefsSave():
	var loadedPlayerPrefs = SaveFileResource.LoadSaveGame()
	if loadedPlayerPrefs == null:
		print("Creating new save file...")
		playerPrefs = SaveFileResource.new()
		playerPrefs.WriteSaveGame()
	else:
		print("Save file loaded successfully.")
		playerPrefs = loadedPlayerPrefs

func loadEncryptedSave():
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
	pass


func get_scoreboard_data() -> Array:
	return safeFile.data.get("scoreboardData", null)
	
