extends CanvasLayer

signal back_pressed

onready var backButton = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/BackButton
onready var windowModeButton = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/WindowModeButton
onready var musicRangeControl = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/MusicVolumeContainer/RangeControl
onready var sfxRangeControl = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/SFXVolumeContainer/RangeControl
onready var panelContainerPivot = $MarginContainer/PanelContainer
var X_
var Y_

var fullscreen = false

func _ready():
	windowModeButton.connect("pressed", self, "on_window_mode_pressed")
	backButton.connect("pressed", self, "on_back_pressed")
	fullscreen = OS.is_window_fullscreen()
	musicRangeControl.connect("percentage_changed", self, "on_music_volume_changed")
	sfxRangeControl.connect("percentage_changed", self, "on_sfx_volume_changed")
	update_display()
	update_initial_volume_settings()

func _process(delta):
	X_ = panelContainerPivot.rect_size.x / 2
	Y_ = panelContainerPivot.rect_size.y / 2
	panelContainerPivot.rect_pivot_offset = Vector2(X_,Y_)
	
func update_display():
	windowModeButton.text = "WINDOWED" if not fullscreen else "FULLSCREEN"	

func update_bus_volume(busName, volumePercent):
	var busIdx = AudioServer.get_bus_index(busName)
	var volumeDb = linear2db(volumePercent)
	AudioServer.set_bus_volume_db(busIdx, volumeDb)
	
func get_bus_volume_percent(busName):
	var busIdx = AudioServer.get_bus_index(busName)
	var volumePercent = db2linear(AudioServer.get_bus_volume_db(busIdx))
	return volumePercent

func update_initial_volume_settings():
	musicRangeControl.set_current_percentage(get_bus_volume_percent("Music"))
	sfxRangeControl.set_current_percentage(get_bus_volume_percent("SFX"))

func on_window_mode_pressed():
	fullscreen =  not fullscreen
	OS.set_window_fullscreen(fullscreen)
	update_display()
	
func on_back_pressed():
	emit_signal("back_pressed")
	
func on_music_volume_changed(percent):
	update_bus_volume("Music", percent)

func on_sfx_volume_changed(percent):
	update_bus_volume("SFX", percent)
