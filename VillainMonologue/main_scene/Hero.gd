extends Node2D

@onready var animation = $Animation
@onready var sprite = $HeroSprite

func dangle_down():
	Event.play_sound("Creak")
	animation.play("dangle_down")

func smug():
	sprite.play("smug")

func angry():
	sprite.play("angry")

func default():
	sprite.play("default")
