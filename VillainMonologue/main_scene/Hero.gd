extends Node2D

@onready var animation = $Animation

func dangle_down():
	Event.play_sound("Creak")
	animation.play("dangle_down")
