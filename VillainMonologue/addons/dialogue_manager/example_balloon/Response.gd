extends TextureButton

@onready var img = $Img
@onready var parent = get_parent()

func _on_button_down():
	var response = get_meta("response")
	parent._on_response_selected(response)
