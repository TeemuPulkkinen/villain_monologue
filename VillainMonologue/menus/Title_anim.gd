extends TextureRect

func _ready():
	var tween = create_tween().set_loops()
	tween.tween_property(self, "position:y", position.y - 100, 2.0).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position:y", position.y, 2.0).set_trans(Tween.TRANS_CUBIC)
