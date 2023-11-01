extends CanvasLayer

onready var playButton = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/PlayButton
onready var optionsButton = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/OptionsButton
onready var quitButton = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/QuitButton
onready var panelContainerPivot = $MarginContainer/PanelContainer
var X_
var Y_

func _ready():
	playButton.connect("pressed", self, "on_play_pressed")
	quitButton.connect("pressed", self, "on_quit_pressed")
	optionsButton.connect("pressed", self, "on_options_pressed")
	
func _process(delta):
	X_ = panelContainerPivot.rect_size.x / 2
	Y_ = panelContainerPivot.rect_size.y / 2
	panelContainerPivot.rect_pivot_offset = Vector2(X_,Y_)
	
func on_play_pressed():
	$"/root/LevelManager".change_level(0)
	
func on_quit_pressed():
	get_tree().quit()
	
func on_options_pressed():
	$"/root/ScreenTransitionManager".transition_to_scene("res://scenes/UI/OptionsMenuStandalone.tscn")
