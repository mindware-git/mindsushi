extends Control


@export var rice_amount: float
var ingredients: Array[Ingredient] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("sushi ready")
	print("initial rice amount: " + str(rice_amount))

	# Control 크기 설정 - 더 크게 만들어서 클릭하기 쉽게
	size = Vector2(100, 100)


	var rice = load("res://src/entity/rice.tres")
	ingredients.append(rice)
	for i in range(ingredients.size()):
		var entity = ingredients[i]
		var sprite = Sprite2D.new()
		sprite.texture = entity.texture
		
		# 스프라이트를 Control 노드 중앙에 위치시키기
		var texture_size = entity.texture.get_size()
		sprite.position = size / 2 # Control 크기의 절반으로 중앙 정렬
		
		add_child(sprite)


func _get_drag_data(at_position: Vector2) -> Variant:
	print("drag at")
	print(at_position)

	var preview_textrue = TextureRect.new()
	var ingredient: Ingredient = load("res://src/entity/rice.tres")
	preview_textrue.texture = ingredient.texture
	
	# 텍스처 크기의 절반만큼 위치를 조정하여 이미지가 마우스 중앙에 오도록 설정
	var texture_size = ingredient.texture.get_size()
	preview_textrue.position = - texture_size / 2

	var preview = Control.new()
	preview.add_child(preview_textrue)

	set_drag_preview(preview)
	# return entity id 1
	return [1]

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	print("can drop at ")
	print(at_position)
	print(data)
	return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	print("drop data at")
	print(at_position)
	print(data)
