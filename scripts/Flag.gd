extends Node2D

signal player_won
var doneLevel = false

func _ready():
	$Area2D.connect("area_entered", self, "on_area_entered")
	
func on_area_entered(_area2d):
	if not doneLevel:
		$Particles2D.emitting = true
		emit_signal("player_won")
		$AudioStreamPlayer.play()
		$RandomAudioStreamPlayer.play()
	doneLevel = true
