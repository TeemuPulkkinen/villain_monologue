extends Node2D

@onready var pows = get_children()

func display_pow(number):
	var pow1 = pows[number]
	pow1.modulate.a = 0.0
	pow1.scale = Vector2(0.4,0.4)
	
	pow1.display()
