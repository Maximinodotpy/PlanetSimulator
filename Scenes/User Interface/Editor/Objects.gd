extends VBoxContainer

var objectRowScene = preload("res://Scenes/User Interface/Editor/Parts/Object Row.tscn")
@onready var no_objects = $CenterContainer/no_objects

func _ready():
	Objects.on_object_added.connect(create_object_row)

func create_object_row(node: Node2D):
	print('Adding Object Row')

	var object_row = objectRowScene.instantiate()

	object_row.object = node

	add_child(object_row)

func _process(delta):
	no_objects.visible = not Objects.is_there_objects()
