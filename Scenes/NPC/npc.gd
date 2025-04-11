extends StaticBody2D

@onready var canvas_layer := $CanvasLayer
@onready var message_label := $CanvasLayer/MessageLabel
@onready var audio_player := $AudioStreamPlayer2D

var can_interact := false
var dialogue_index := 0

@export var dialogue_lines: Array[String] = ['Hello!', 'I\'m an NPC!']

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('action') && can_interact:
		if dialogue_index < dialogue_lines.size():
			canvas_layer.visible = true
			get_tree().paused = true

			message_label.text = dialogue_lines[dialogue_index]
			dialogue_index += 1

			audio_player.play()
		else:
			canvas_layer.visible = false
			dialogue_index = 0
			get_tree().paused = false
