extends Resource
class_name SaveFileResource

const SAVE_GAME_PATH := "user://savegame.tres"

@export var scoreboardRes : ScoreboardResource

func init() -> void:
	# If scoreboardRes is not already loaded from a file, create a new one.
	if not scoreboardRes:
		scoreboardRes = load("uid://cgk8bd70bc36")

func WriteSaveGame():
	ResourceSaver.save(self, SAVE_GAME_PATH)
	print("Progress Saved")

static func LoadSaveGame() -> Resource:
	if ResourceLoader.exists(SAVE_GAME_PATH):
		return load(SAVE_GAME_PATH)
	return null
	
