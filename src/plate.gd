extends TextureRect

# make plate with ingredient

var ingredients: Array[Ingredient] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _get_drag_data(at_position: Vector2) -> Variant:
	print("drag at")
	print(at_position)

	#var preview_textrue = TextureRect.new()
	#var ingredient: Ingredient = load("res://src/entity/rice.tres")
	#preview_textrue.texture = ingredient.texture
#
	#var preview = Control.new()
	#preview.add_child(preview_textrue)
#
	#set_drag_preview(preview)
	# return entity id 1
	return [1]

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	print("data is ", data)
	if data is Array[int]:
		print("drop data")
		return true
	return false


func _drop_data(_at_position: Vector2, data: Variant) -> void:
	# TODO: Change to Savemanager
	print("drop data in plate")
	assert(data is Array[int])
	for id in data:
		print("id is ", id)
		var ingredient: Ingredient = load("res://src/entity/rice.tres")
		ingredients.append(ingredient)
	# show update
