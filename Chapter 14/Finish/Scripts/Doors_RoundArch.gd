extends Node3D

@export var backpack : Node

@onready var key_collected:bool = false
var is_open:bool = false

func _ready():
	backpack.connect("key_collected", on_key_collected)

func on_key_collected():
	key_collected = true

func _on_Area_body_entered(body):
	if body.name == "Player" and is_open == false:
		if key_collected:
			$OpenDoor.play()
			$AnimationPlayer.play("Open")
			is_open = true
		else:
			$LockFiddling.play()
		
func load_level():
	EventBus.emit_signal("change_level", "Level-02.tscn")
