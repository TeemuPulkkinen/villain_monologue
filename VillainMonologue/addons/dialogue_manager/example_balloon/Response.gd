extends TextureButton

@onready var img = $Img
@onready var parent = get_parent()

func _on_button_down():
	var response = get_meta("response")
	parent._on_response_selected(response, self)

func select():
	# do animation here
	print("select animation playing")
	await get_tree().create_timer(0.5).timeout
	return true
