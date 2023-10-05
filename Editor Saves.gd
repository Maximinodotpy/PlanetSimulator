extends Node

var currentSaveName = ''

const savesDir = 'user://saves'
const mainFileName = 'planets.cfg'

const snapShotSubDir = 'snapshots'

func get_all_saves():
	pass

func get_all_save_names():
	var dir = DirAccess.get_directories_at(savesDir)
	return dir

func delete_save(name: String):
	return OS.move_to_trash(ProjectSettings.globalize_path(savesDir + '/' + name))


func is_save_name_valid(name: String):
	if name == '':
		return false

func get_save_dir(save_name):
	return savesDir + '/' + save_name + '/'

func get_main_file_path(save_name):
	return get_save_dir(save_name) + mainFileName

func load_file():
	print('Loading "%s"' % currentSaveName)
	var saveFile = ConfigFile.new()
	saveFile.load(get_main_file_path(currentSaveName))

	for section in saveFile.get_sections():
		var planet = EditorGlobal.add_object(EditorGlobal.OBJECT_TYPES.Planet)

		planet.name = section
		planet.position = saveFile.get_value(section, 'position', Vector2(0, 0))
		planet.motion = saveFile.get_value(section, 'motion', Vector2(0, 0))
		## TODO ADD Other Properties


func save_file():
	print('Saving "%s"' % currentSaveName)
	DirAccess.make_dir_recursive_absolute(savesDir + '/' + currentSaveName + '/')

	var main_file_path = get_main_file_path(currentSaveName)

	Helpers.ensureFileExists(main_file_path)

	var saveFile = ConfigFile.new()

	## Saving Objects
	for object in get_tree().get_nodes_in_group('gravity_object'):
		saveFile.set_value(object.name, 'position', object.position)
		saveFile.set_value(object.name, 'motion', object.motion)
		## TODO ADD Other Properties

	saveFile.save(main_file_path)




