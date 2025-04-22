extends Button

func _ready():
	connect("pressed", Callable(self, "on_pressed"))
	
func on_pressed():
	get_parent().visible = false
	get_node("../AudioStreamPlayer").play()
