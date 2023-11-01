extends Position2D


enum Direction { Right, Left }

export(PackedScene) var enemyScene
export(Direction) var startDirection

var currentEnemyNode = null
var spawnOnNextTick = false


func _ready():
	$SpawnTimer.connect("timeout", self, "on_spawn_time_timeout")
	call_deferred("spawn_enemy")
	
func spawn_enemy():
	currentEnemyNode = enemyScene.instance()
	currentEnemyNode.startDirection = Vector2.RIGHT if startDirection == Direction.Right else Vector2.LEFT
	get_parent().add_child(currentEnemyNode)
	currentEnemyNode.global_position = global_position

func check_enemy_spawn():
	if not is_instance_valid(currentEnemyNode):
		if spawnOnNextTick:
			spawn_enemy()
			spawnOnNextTick = false
		else:
			spawnOnNextTick = true
		
func on_spawn_time_timeout():
	check_enemy_spawn()
