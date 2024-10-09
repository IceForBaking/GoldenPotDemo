extends Node

enum LOCATIONS{
	PLAY,
	MAIN_MENU,
	LEVELS,
	SETTINGS,

}

signal location_changed(location: LOCATIONS)
