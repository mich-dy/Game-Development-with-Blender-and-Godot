extends CanvasLayer

@export var note_trigger : Node

func _ready() -> void:
	note_trigger.connect("show_note", _on_show_note)

func _on_show_note() -> void:
	$Panel.visible = true
