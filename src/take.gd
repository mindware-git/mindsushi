extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	print("Checking if food can be dropped on customer...")
	var customer = get_parent().get_parent()
	if customer and customer.current_state == customer.CustomerState.WAITING:
		print("Customer is waiting, can drop food")
		return true
	print("Customer is not waiting, cannot drop food")
	return false

func _drop_data(_at_position: Vector2, _data: Variant) -> void:
	print("Dropping food on customer...")
	var customer = get_parent().get_parent()
	if customer and customer.current_state == customer.CustomerState.WAITING:
		customer._take_food()
