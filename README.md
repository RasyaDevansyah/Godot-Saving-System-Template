# Godot Saving System Template

<img width="1146" height="651" alt="image" src="https://github.com/user-attachments/assets/bfb6e25b-9906-461e-9ed0-9c9564f2ca52" />
<img width="1107" height="615" alt="image" src="https://github.com/user-attachments/assets/affe4cee-ceae-4174-b12c-074d36f2ed3d" />


A minimal, easy-to-integrate saving system for Godot (resources + encrypted save) with a simple offline leaderboard example. Designed to be dropped into your own Godot projects and used as a template for both plain Resource saves (player prefs) and encrypted save files (game progress / leaderboard).

## Features

- Resource-based player preferences (`SaveFileResource`) with a single-file save at `user://savegame.tres`.
- Encrypted save file support (`EncryptedSaveFileResource`) using Godot's `FileAccess.open_encrypted_with_pass` and a separate `encryption.tres` key resource.
- Simple global autoload wrapper (`SaveGlobalScript.gd`) that exposes convenience methods and holds the safe/encrypted save and player prefs.
- Example scoreboard UI that reads from the encrypted save's `scoreboardData` array of dictionaries ({ name, score }).
- Minimal, commented scripts and resources so you can customize the data shape easily.

## Quick Start / Setup

1. Open this project in Godot or copy the following folders/files into your project (keep the paths):
	- `Scenes/` (menu, game, scoreboard UI scenes)
	- `Scripts/Autoload/SaveGlobalScript.gd` (autoload wrapper)
	- `Scripts/ResourceSaveFileSystem/SaveFileResource.gd`
	- `Scripts/EncryptedSaveFileSystem/EncryptedSaveFileResource.gd`
	- `Scripts/EncryptedSaveFileSystem/encryption.tres` (encryption key resource)

<img width="422" height="162" alt="image" src="https://github.com/user-attachments/assets/df7f3f72-8e1d-411b-a16b-c41dd5904346" />


NOTE: The `Scripts/EncryptedSaveFileSystem` and `Scripts/ResourceSaveFileSystem` folders are intended as standalone templates. If you want to reuse only the saving system in another project, copy these two folders (and `encryption.tres`) into your project and register the `SaveGlobalScript.gd` autoload in that project. Keep the relative resource path or update the path in `EncryptedSaveFileResource.gd` to match your new location.

2. Register the autoload (singleton):
	 - In Godot Editor: Project -> Project Settings -> Autoload
	 - Add `res://Scripts/Autoload/SaveGlobalScript.gd` and set the Node Name to `GlobalScript` (the project uses `GlobalScript` in scenes/scripts).

<img width="1179" height="234" alt="image" src="https://github.com/user-attachments/assets/83c31c3a-81eb-4837-bcdc-490e2bc8af6a" />


3. Ensure the encryption resource path is valid:
	 - `EncryptedSaveFileResource.gd` loads the key from `res://Scripts/EncryptedSaveFileSystem/encryption.tres`. Replace this path or the resource as needed.

4. Run the project and test the flow:
	 - From the Menu press Play to open `Scenes/game.tscn`.
	 - Press "Get Points" to increase score, then "End game" to open the Save UI.
	 - Enter a name and press Submit to append the entry to the encrypted scoreboard and write the save.
	 - Open the scoreboard screen from the main menu to see saved entries.

## How it works (short)

- SaveFileResource (`Scripts/ResourceSaveFileSystem/SaveFileResource.gd`)
	- A `Resource` with exported variables you can use for player preferences (volume, settings, etc.).
	- Methods:
		- `WriteSaveGame()` — saves the resource to `user://savegame.tres` using `ResourceSaver.save`.
		- `static LoadSaveGame()` — returns the loaded Resource or `null` if it doesn't exist.

- EncryptedSaveFileResource (`Scripts/EncryptedSaveFileSystem/EncryptedSaveFileResource.gd`)
	- Holds an arbitrary `Dictionary` in `data` and writes/reads it encrypted to `user://encryptedsavegame.res`.
	- Methods:
		- `set_data(newData : Dictionary)` — set the runtime dictionary to save.
		- `WriteSaveGame()` — opens an encrypted FileAccess and stores `JSON.stringify(data)`.
		- `LoadSaveGame()` — reads and parses the encrypted JSON into `data`.
	- Note: it expects an `Encryption` resource at `res://Scripts/EncryptedSaveFileSystem/encryption.tres` (edit path if you move it).

- Global/autoload wrapper (`Scripts/Autoload/SaveGlobalScript.gd`)
	- Loads both save systems on `_ready()` and provides convenience accessors used by scenes, for example
		- `get_scoreboard_data()` — returns `safeFile.data.get("scoreboardData")` which the scoreboard UI uses.
	- On first run the autoload creates a default encrypted save with an example scoreboard entry.

- UI flow in this template
	- `Scenes/game.tscn` contains a simple game UI: a "Get Points" button (adds score), "End game" (open Save UI).
	- `Scenes/Game/SaveUI` collects a player name and on Submit appends `{name, score}` to `GlobalScript`'s scoreboard data and calls `safeFile.WriteSaveGame()`.
	- `Scenes/Menu/Scoreboard/scoreboard.gd` queries `GlobalScript.get_scoreboard_data()`, sorts by score, and instantiates `scoreboard_row.tscn` for each entry.

## Folder structure

```
Scenes/
	Game/
		game.tscn              # Example play scene with save UI
		game_ui.gd             # Handles scoring and UI transitions
		save_ui.gd             # Submit player name -> write encrypted save
	Menu/
		menu.tscn
		menu.gd
		Scoreboard/            # UI for listing high scores
			scoreboard.tscn
			scoreboard.gd
			scoreboard_row.tscn
			ScoreboardResource.gd
			ScoreboardRowResource.gd

Scripts/
	Autoload/
		SaveGlobalScript.gd    # Autoload (singleton) wrapper (register as "GlobalScript")
	ResourceSaveFileSystem/
		SaveFileResource.gd    # Simple preferences Resource save
	EncryptedSaveFileSystem/
		EncryptedSaveFileResource.gd  # Encrypted JSON save
		encryption.tres        # Encryption key resource (used by EncryptedSaveFileResource)

Resources/
	Scoreboard.tres          # Optional resource examples

README.md
project.godot
```

## Customization

- To change what gets stored in the encrypted save, update the `Dictionary` structure used in `EncryptedSaveFileResource.data` and how `SaveGlobalScript.gd` initializes or accesses it.

<img width="643" height="613" alt="image" src="https://github.com/user-attachments/assets/a64020ba-b73e-424b-a000-0599f7ac8486" />


<img width="509" height="522" alt="image" src="https://github.com/user-attachments/assets/1fe055f1-93a7-411e-9dc3-c83a122e07f4" />


- `SaveFileResource.gd` exposes exported variables (sound, music, cameraShake) — modify or add exported properties for additional player prefs.
- Swap or regenerate `encryption.tres` if you need to change the encryption key (be mindful that changing the key will prevent old saves from being read).

Template usage note
- The `Scripts/EncryptedSaveFileSystem` and `Scripts/ResourceSaveFileSystem` folders are deliberately small and self-contained so you can copy them into other projects as a saving system template.
- Copy steps:
	1. Copy `Scripts/EncryptedSaveFileSystem/` and `Scripts/ResourceSaveFileSystem/` (and `encryption.tres`) into the target project's `res://Scripts/` folder (or adapt to your preferred path).
	2. Copy `Scripts/Autoload/SaveGlobalScript.gd` into your project and register it as an Autoload (Node name `GlobalScript`) so scenes can access `GlobalScript.safeFile` and `GlobalScript.playerPrefs`.
	3. Update `EncryptedSaveFileResource.gd` if you moved `encryption.tres` to a different path.
	4. Use `GlobalScript.get_scoreboard_data()` or call `safeFile.WriteSaveGame()` from your UI/game logic to persist data.

## Credits

Created by [RasyaDevansyah](https://github.com/RasyaDevansyah)

---

Feel free to use, modify, and share this saving/leaderboard template in your own Godot projects.
