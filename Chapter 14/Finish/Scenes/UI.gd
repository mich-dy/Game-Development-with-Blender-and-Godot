extends CanvasLayer

@export var note_trigger : Node

func _ready():
	note_trigger.connect("show_note", on_show_note)

func on_show_note():
	$Panel.visible = true
