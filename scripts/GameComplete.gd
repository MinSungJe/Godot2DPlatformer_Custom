extends CanvasLayer

onready var continueButton = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ContinueButton
onready var panelContainerPivot = $MarginContainer/PanelContainer
var X_
var Y_

func _ready():
	continueButton.connect("pressed", self, "on_continue_pressed")

func _process(delta):
	X_ = panelContainerPivot.rect_size.x / 2
	Y_ = panelContainerPivot.rect_size.y / 2
	panelContainerPivot.rect_pivot_offset = Vector2(X_,Y_)
	
func on_continue_pressed():
	$"/root/ScreenTransitionManager".transition_to_menu()
