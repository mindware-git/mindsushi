extends Node2D

@onready var time_label = $CanvasLayer/VBoxContainer/HBoxContainer/TimeLabel
@onready var money_label = $CanvasLayer/VBoxContainer/HBoxContainer/MoneyLabel
@onready var restaurant = $Restaurant
@onready var cook = $Cook

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_label.text = "Time: " + str(SaveManager.game_data.running_time)
	money_label.text = "Money: " + str(SaveManager.game_data.money) + "$"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if SaveManager.game_data.money > 1000 or SaveManager.game_data.money < 0:
		get_tree().change_scene_to_file("res://src/ending.tscn")


func _on_timer_timeout() -> void:
	SaveManager.game_data.running_time += 1
	time_label.text = "Time: " + str(SaveManager.game_data.running_time)
	money_label.text = "Money: " + str(SaveManager.game_data.money) + "satisfied customers: " + str(SaveManager.game_data.total_satisfaction) + "num of customers: " + str(SaveManager.game_data.num_customer)

	if SaveManager.game_data.running_time % 100 == 0:
		SaveManager.save_game()
	if SaveManager.game_data.running_time % 60 * 24 * 30 == 0:
		SaveManager.game_data.money -= 1000

func _on_restaurant_button_pressed() -> void:
	restaurant.show()
	cook.hide()
	$CanvasLayer/RestaurantButton.hide()
	$CanvasLayer/ChefButton.show()
	restaurant.update_plate()

func _on_chef_button_pressed() -> void:
	restaurant.hide()
	cook.show()
	$CanvasLayer/RestaurantButton.show()
	$CanvasLayer/ChefButton.hide()
