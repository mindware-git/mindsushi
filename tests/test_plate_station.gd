extends GutTest

@onready var plate_station_preload = preload("res://src/plate_station.tscn")

func before_each():
	if FileAccess.file_exists(SaveManager.DEBUG_SAVE_FILE_PATH):
		DirAccess.remove_absolute(SaveManager.DEBUG_SAVE_FILE_PATH)

	SaveManager.game_data = GameData.new()

func test_number_of_plates():
	SaveManager.game_data.plate_food.append([1])
	var plate_station_instance = plate_station_preload.instantiate()
	add_child(plate_station_instance)
	assert_eq(plate_station_instance.get_child_count(), 3)
	plate_station_instance.queue_free()
	await get_tree().process_frame
