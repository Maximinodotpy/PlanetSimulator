extends HBoxContainer

var object: Node2D

@onready var selected_button = $"Selected Button"
@onready var line_edit = $LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	if object:
		line_edit.text = object.name

	Objects.on_object_removed.connect(on_any_removed)
	Selection.selection_changed.connect(on_any_selected)

	selected_button.pressed.connect(toggle_selection)
	line_edit.text_submitted.connect(name_changed)

func name_changed(new_text: String):
	Objects.rename_object(object, new_text)
	line_edit.text = object.name
	line_edit.release_focus()

func on_any_removed(node: Node2D):
	if node == object:
		queue_free()

func on_any_selected():
	if object in Selection.get_selection():
		selected_button.button_pressed = true
		selected_button.text = 'Unselect'
	else:
		selected_button.button_pressed = false
		selected_button.text = 'Select'

func toggle_selection():
	if selected_button.button_pressed:
		Selection.add_to_selection(object)
	else:
		Selection.remove_from_selection(object)
