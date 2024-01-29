extends Control

@onready var blackout = %Blackout

func _ready():
	Event.sound_library = $SoundLibrary
	black_in()

func black_in():
	blackout.show()
	blackout.modulate.a = 1.0
	var tween = create_tween()
	tween.tween_property(blackout, "modulate:a",0.0, 0.5)
	await tween.finished
	blackout.hide()
	return true

func black_out(time):
	blackout.show()
	var tween = create_tween()
	tween.tween_property(blackout, "modulate:a",1.0, time)
	return tween.finished


func _on_main_menu_button_blackout():
	black_out(0.5)


func _on_karaoke_blackout():
	black_out(1.0)
