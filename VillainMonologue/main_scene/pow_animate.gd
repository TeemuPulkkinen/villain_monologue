extends Sprite2D

@onready var animation = $Animation
@onready var audio = $Audio

func display():
	animation.play("appear")
	audio.play()
