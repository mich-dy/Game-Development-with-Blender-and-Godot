extends Node3D

signal key_collected

func _on_Area_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		$AudioStreamPlayer.play()
		emit_signal("key_collected")
