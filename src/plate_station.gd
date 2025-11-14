extends Node2D

@onready var plate_template = $Plate

func _ready() -> void:
	for foods in SaveManager.game_data.plate_food:
		var plate_instance = plate_template.duplicate()
		add_child(plate_instance)
	
	plate_template.visible = false
