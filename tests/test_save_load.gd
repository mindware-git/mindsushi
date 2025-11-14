extends GutTest

func before_each():
	if FileAccess.file_exists(SaveManager.DEBUG_SAVE_FILE_PATH):
		DirAccess.remove_absolute(SaveManager.DEBUG_SAVE_FILE_PATH)

	SaveManager.game_data = GameData.new()

func test_save_and_load():
	SaveManager.game_data.money = 150
	SaveManager.save_game()

	SaveManager.game_data = GameData.new()
	SaveManager.format_check()
	assert_eq(SaveManager.game_data.money, 150)
