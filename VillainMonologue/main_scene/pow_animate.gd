extends Sprite2D

@onready var animation = $Animation
@onready var audio = $Audio

func display():
	show()
	animation.play("appear")
	audio.play()
