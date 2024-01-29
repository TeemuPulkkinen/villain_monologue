extends Control

@onready var blackout = %Blackout

func _ready():
	blackout.hide()
	Event.sound_library = $SoundLibrary

func black_out():
	blackout.show()
	var tween = create_tween()
	tween.tween_property(blackout, "modulate:a",1.0, 0.5)
	return tween.finished
