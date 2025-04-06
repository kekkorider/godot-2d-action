extends StaticBody2D

@onready var canvas_layer := $CanvasLayer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('action') && Game.player_can_interact:
		if canvas_layer.visible:
			canvas_layer.visible = false
			get_tree().paused = false
		else:
			canvas_layer.visible = true
			get_tree().paused = true
