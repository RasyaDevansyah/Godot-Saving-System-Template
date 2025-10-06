extends Resource
class_name SaveFileResource

const SAVE_GAME_PATH := "user://savegame.tres"

#CHANGE THESE VARIABLES TO ANY DATA YOU WANT-----------
@export var sound : float = 0
@export var music : float = 0
@export var cameraShake : bool = true
#----------------------------------------------------

func WriteSaveGame():
	ResourceSaver.save(self, SAVE_GAME_PATH)
	print("Player Prefs Saved")

static func LoadSaveGame() -> Resource:
	if ResourceLoader.exists(SAVE_GAME_PATH):
		return load(SAVE_GAME_PATH)
	return null
	
