extends PopupMenu

const PAUSE = 'Pause'
const PAUSE_INDEX = 0

const RESUME = 'Resume'
const RESUME_INDEX = 1

var TIME_TOGGLE_SHORTCUT = EditorGlobal.createShortcut(KEY_SPACE)

const RESET_SIMULATION_SPEED = 'Reset Simulation Speed'
const RESET_SIMULATION_SPEED_INDEX = 2

const SLOWEST_SIMULATION_SPEED = 'Slowest Simulation Speed'
const SLOWEST_SIMULATION_SPEED_INDEX = 3

const SLOWER_SIMULATION_SPEED = 'Slower Simulation Speed'
const SLOWER_SIMULATION_SPEED_INDEX = 4

const FASTER_SIMULATION_SPEED = 'Faster Simulation Speed'
const FASTER_SIMULATION_SPEED_INDEX = 5

const FASTEST_SIMULATION_SPEED = 'Fastest Simulation Speed'
const FASTEST_SIMULATION_SPEED_INDEX = 6


# Called when the node enters the scene tree for the first time.
func _ready():
	add_item(PAUSE, PAUSE_INDEX)
	set_item_shortcut(PAUSE_INDEX, TIME_TOGGLE_SHORTCUT)

	add_item(RESUME, RESUME_INDEX)
	set_item_shortcut(RESUME_INDEX, TIME_TOGGLE_SHORTCUT)

	add_separator('Simulation Speed')

	add_item(RESET_SIMULATION_SPEED, RESET_SIMULATION_SPEED_INDEX)
	add_item(SLOWEST_SIMULATION_SPEED, SLOWEST_SIMULATION_SPEED_INDEX)
	add_item(SLOWER_SIMULATION_SPEED, SLOWER_SIMULATION_SPEED_INDEX)
	add_item(FASTER_SIMULATION_SPEED, FASTER_SIMULATION_SPEED_INDEX)
	add_item(FASTEST_SIMULATION_SPEED, FASTEST_SIMULATION_SPEED_INDEX)

	index_pressed.connect(indexPressed)
	EditorGlobal.anything_changed.connect(react)
	react()

func indexPressed(index: int):
	match get_item_text(index):
		PAUSE: EditorGlobal.pause_simulation()
		RESUME: EditorGlobal.resume_simulation()
		RESET_SIMULATION_SPEED: EditorGlobal.reset_simulation_speed()
		SLOWEST_SIMULATION_SPEED: EditorGlobal.simulation_slowest()
		SLOWER_SIMULATION_SPEED: EditorGlobal.simulation_slower()
		FASTEST_SIMULATION_SPEED: EditorGlobal.simulation_fastest()
		FASTER_SIMULATION_SPEED: EditorGlobal.simulation_faster()


func react():
	# Disable Resume in case the simulation is not paused
	set_item_disabled(RESUME_INDEX, not get_tree().paused)

	# Disable Pause in case the simulation is paused
	set_item_disabled(PAUSE_INDEX, get_tree().paused)

	# Disable Reset Simulation Speed in case the simulation speed is already at the default value
	set_item_disabled(RESET_SIMULATION_SPEED_INDEX, EditorGlobal.get_simulation_speed() == EditorGlobal.DEFAULT_SIMULATION_SPEED)

	# Disable Slowest Simulation Speed in case the simulation speed is already at the slowest value
	set_item_disabled(SLOWEST_SIMULATION_SPEED_INDEX, EditorGlobal.is_simulation_slowest())

	# Disable Fastest Simulation Speed in case the simulation speed is already at the fastest value
	set_item_disabled(FASTEST_SIMULATION_SPEED_INDEX, EditorGlobal.is_simulation_fastest())
