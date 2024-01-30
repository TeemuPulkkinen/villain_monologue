extends Node2D
@onready var rope = $Rope
@onready var bomb = $Bomb
@onready var spark = $Spark
@onready var boom_sound = $Boom
@onready var sss_sound = $Sss
var stopped = false

# Start countdown & animate rope burning
func start_timer(time):
	show()
	spark.show()
	bomb.animation = "default"
	# Tween rope progress bar to go to 0 over time given
	# and spark x location
	rope.value = 100
	spark.position.x = 1116
	var tween = create_tween().set_parallel()
	tween.tween_property(rope, "value", 0, time)
	tween.tween_property(spark, "position:x", 404, time)
	#Sound
	sss_sound.play()
	
	# Tween spark's movement

	# Start timer
	stopped = false
	await get_tree().create_timer(time).timeout
	if stopped:
		return
	
	# Animate explosion
	sss_sound.stop()
	spark.hide()
	bomb.play("explode")
	boom_sound.play()
	# Trigger next dialogue
	get_node("/root/Main/ExampleBalloon/%ResponsesMenu")._on_timer_ended()
	
	return true

func stop_timer():
	stopped = true
	sss_sound.stop()
	hide()

func _on_bomb_animation_finished():
	spark.hide()
	if bomb.animation == "explode":
		hide()
