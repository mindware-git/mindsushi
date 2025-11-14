extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is Array:
		for item in data:
			if not item is FoodEntity:
				return false
		return true
	return false

func _drop_data(_at_position: Vector2, _data: Variant) -> void:
	# Check who is take drop
	pass
