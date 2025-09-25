extends Resource
class_name EncryptedSaveFileResource

const SAVE_GAME_PATH := "user://encryptedsavegame.res"
var encryption : Encryption
var data : Dictionary
var access : FileAccess

func _init() -> void:
	encryption = ResourceLoader.load("res://Resources/encryption.tres")

func set_data(newData : Dictionary) -> void:
	data = newData

func WriteSaveGame() -> void:
	access = FileAccess.open_encrypted_with_pass(SAVE_GAME_PATH, FileAccess.WRITE, encryption.key)
	access.store_string(JSON.stringify(data))
	access.close()
	print("Progress Saved")

func LoadSaveGame() -> bool:
	if FileAccess.file_exists(SAVE_GAME_PATH):
		access = FileAccess.open_encrypted_with_pass(SAVE_GAME_PATH, FileAccess.READ, encryption.key)
		data = JSON.parse_string(access.get_as_text())
		print("safe File loaded")
		return true
	return false
	
