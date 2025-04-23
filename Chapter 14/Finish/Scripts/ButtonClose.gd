extends Button

func _ready() -> void:
	connect("pressed", _on_pressed)
	
func _on_pressed() -> void:
	get_parent().visible = false
	get_node("../AudioStreamPlayer").play()
