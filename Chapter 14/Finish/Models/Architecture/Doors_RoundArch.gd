extends Node3D

@export var backpack : Node

@onready var key_collected:bool = false
var is_open:bool = false

func _ready() -> void:
	backpack.connect("key_collected", _on_key_collected)

func _on_key_collected() -> void:
	key_collected = true

func _on_Area_body_entered(body: Node3D) -> void:
	if body.name == "Player" and is_open == false:
		if key_collected:
			$OpenDoor.play()
			$AnimationPlayer.play("Open")
			is_open = true
		else:
			$LockFiddling.play()
