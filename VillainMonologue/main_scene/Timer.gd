extends Node2D

@onready var rope = $Rope
@onready var bomb = $Bomb

# Start countdown & animate rope burning
func start_timer(time):
	show()

	# Tween rope progress bar to go to 0 over time given
	rope.value = 100
	var tween = create_tween()
	tween.tween_property(rope, "value", 0, time)
	
	# Tween spark's movement

	# Start timer
	await get_tree().create_timer(time).timeout
	
	# Animate explosion
	bomb.play("explode")
	
	return true


func _on_bomb_animation_finished():
	if bomb.animation == "explode":
		hide()
