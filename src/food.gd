extends Control
# Food, sub texture will textrect

var foods: Array[FoodEntity] = []

func _ready() -> void:
	# add to groups
	add_to_group("food")

func _get_drag_data(_at_position: Vector2) -> Variant:
	if foods.is_empty():
		return null

	var preview = Control.new()
	set_drag_preview(preview)
	return foods

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is FoodEntity:
		return true
	return false

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	foods.append(data)
