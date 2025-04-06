extends StaticBody2D

@onready var canvas_layer := $CanvasLayer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('action'):
		if canvas_layer.visible:
			canvas_layer.visible = false
		else:
			canvas_layer.visible = true
