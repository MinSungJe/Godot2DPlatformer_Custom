extends CanvasLayer
onready var panelContainerPivot = $MarginContainer/PanelContainer
var X_
var Y_

func _ready():
	$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/NextLevelButton.connect("pressed", self, "on_next_button_pressed")
	$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/RestartButton.connect("pressed", self, "on_restart_button_pressed")

func _process(delta):
	X_ = panelContainerPivot.rect_size.x / 2
	Y_ = panelContainerPivot.rect_size.y / 2
	panelContainerPivot.rect_pivot_offset = Vector2(X_,Y_)

func on_next_button_pressed():
	$"/root/LevelManager".increment_level()
	
func on_restart_button_pressed():
	$"/root/LevelManager".restart_level()
