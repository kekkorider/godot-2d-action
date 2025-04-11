extends StaticBody2D

signal switch_activated
signal switch_deactivated

@onready var sprite := $AnimatedSprite2D
@onready var audio_player := $AudioStreamPlayer2D

var can_interact := false
var is_activated := false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('action') && can_interact:
		is_activated = !is_activated
		sprite.play('activated' if is_activated else 'deactivated')

		audio_player.play()

		if is_activated: switch_activated.emit()
		else: switch_deactivated.emit()
