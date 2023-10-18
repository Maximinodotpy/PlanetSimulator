extends Node

signal on_toggle_side_panel
signal on_toggle_status_bar
signal on_toggle_origin_marker
signal on_toggle_background_grid
signal on_toggle_side_panel_position

const UI_CONFIG_PATH = 'user://ui_config.cfg'

func get_user_interface_config() -> ConfigFile:
	var config = ConfigFile.new()
	config.load(UI_CONFIG_PATH)
	return config

func get_config_value(key: String, default = null):
	return get_user_interface_config().get_value('u', key, default)

func set_config_value(key: String, value):
	var conf = UserInterface.get_user_interface_config()
	conf.set_value('u', key, value)
	conf.save(UserInterface.UI_CONFIG_PATH)
