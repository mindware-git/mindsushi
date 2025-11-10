extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_plate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update_plate() -> void:
	# 기존 스프라이트들 모두 제거
	for child in $Plate.get_children():
		child.queue_free()
	
	# 새로운 스프라이트들 추가
	for ingredients in SaveManager.game_data.ready_food:
		for i in range(ingredients.size()):
			var entity = ingredients[i]
			var sprite = Sprite2D.new()
			sprite.texture = entity.texture
			$Plate.add_child(sprite)
