extends Node

func _ready() -> void:
	EventBus.connect("change_level", change_level)

func change_level(level: String) -> void:
	var new_level = load("res://Scenes/" + level).instantiate()
	
	$Level.remove_child($Level.get_child(0))
	$Level.add_child(new_level)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
