extends TextureRect

func _ready():
	var tween = create_tween().set_loops()
	tween.tween_property(self, "position:y", position.y - 50, 1.0).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position:y", position.y, 1.0).set_trans(Tween.TRANS_SINE)
