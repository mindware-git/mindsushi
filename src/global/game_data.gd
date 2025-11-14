extends Resource
class_name GameData

const LATEST_FORMAT_VERSION = 1
@export var format_version: int = LATEST_FORMAT_VERSION
@export var owned_entities: Array[int] = []
@export var running_time: int = 0
@export var money: int = 0
@export var plate_food: Array[Array] = [[]]
@export var num_customer: int = 0
@export var total_satisfaction: int = 0
