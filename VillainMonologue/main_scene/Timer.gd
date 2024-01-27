extends Node2D

@onready var rope = $Rope
@onready var bomb = $Bomb
var stopped = false

# Start countdown & animate rope burning
func start_timer(time):
	show()

	# Tween rope progress bar to go to 0 over time given
	rope.value = 100
	var tween = create_tween()
	tween.tween_property(rope, "value", 0, time)
	
	# Tween spark's movement

	# Start timer
	stopped = true
	await get_tree().create_timer(time).timeout
	if stopped:
		return
	
	# Animate explosion
	bomb.play("explode")
	
	return true

func stop_timer():
	stopped = true
	hide()

func _on_bomb_animation_finished():
	if bomb.animation == "explode":
		hide()
