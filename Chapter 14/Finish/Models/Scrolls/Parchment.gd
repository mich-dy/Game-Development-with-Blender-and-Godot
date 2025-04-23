extends Node3D

signal show_note

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		emit_signal("show_note")
