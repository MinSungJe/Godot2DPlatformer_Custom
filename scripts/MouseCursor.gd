extends CanvasLayer

var current_mouse_position = Vector2.ZERO
var past_mouse_position = Vector2.ZERO

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	
func _process(_delta):
	current_mouse_position = $Sprite.get_global_mouse_position()
	check_mouse_moved()
	
	$Sprite.global_position = $Sprite.get_global_mouse_position()
	if Input.is_action_just_pressed("click"): $AnimationPlayer.play("click")
	
	past_mouse_position = $Sprite.get_global_mouse_position()
	
	
func toggle_mouse_visible():
	if $Sprite.visible == true: $Sprite.visible = false
	else: $Sprite.visible = true


func check_mouse_moved():
	if current_mouse_position != past_mouse_position:
		$IdleTimer.start()
		if not $Sprite.visible:
			toggle_mouse_visible()
	if $Sprite.visible and $IdleTimer.is_stopped(): toggle_mouse_visible()
