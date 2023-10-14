extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	EditorSaves.started_saving.connect(show)
	EditorSaves.finished_saving.connect(hide)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
