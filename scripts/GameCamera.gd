extends Camera2D

var targetPosition = Vector2.ZERO

export(Color, RGB) var BackgroundColor
export (OpenSimplexNoise) var shakeNoise

var xNoiseSampleVector = Vector2.RIGHT
var yNoiseSampleVector = Vector2.DOWN
var xNoiseSamplePosition = Vector2.ZERO
var yNoiseSamplePosition = Vector2.ZERO
var noiseSamepleTravelRate = 500
var maxShakeOffset = 10
var currentShakePercentage = 0
var shakeDecay = 3

func _ready():
	VisualServer.set_default_clear_color(BackgroundColor)

func _process(delta):
	acquire_target_position()
	global_position = lerp(targetPosition, global_position, pow(2, -15 * delta))
		
	if currentShakePercentage:
		xNoiseSamplePosition += xNoiseSampleVector * noiseSamepleTravelRate * delta
		yNoiseSamplePosition += yNoiseSampleVector * noiseSamepleTravelRate * delta
		var xSample = shakeNoise.get_noise_2d(xNoiseSamplePosition.x, xNoiseSamplePosition.y)
		var ySample = shakeNoise.get_noise_2d(yNoiseSamplePosition.x, yNoiseSamplePosition.y)
		
		var calculateOffset = Vector2(xSample, ySample) * maxShakeOffset * currentShakePercentage * pow(currentShakePercentage, 2)
		set_offset(calculateOffset)
		
		currentShakePercentage = clamp(currentShakePercentage - shakeDecay * delta, 0, 1)
		

func apply_shake(percentage):
	currentShakePercentage = clamp(currentShakePercentage + percentage, 0, 1)
		
		
func acquire_target_position():
	var acquired = get_target_position_from_node_group("player")
	if not acquired: get_target_position_from_node_group("player_death")

func get_target_position_from_node_group(groupName):
	var nodes = get_tree().get_nodes_in_group(groupName)
	if nodes:
		var node = nodes[0]
		targetPosition = node.global_position
		return true
	return false
