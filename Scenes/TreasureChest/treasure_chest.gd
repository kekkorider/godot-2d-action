extends StaticBody2D

@onready var sprite := $AnimatedSprite2D
@onready var loot_sprite := $LootSprite
@onready var player := $AnimationPlayer

var can_interact := false
var is_open := false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('action') && can_interact && !is_open:
		is_open = true
		sprite.play('open')

		loot_sprite.visible = true
		player.play('animate_in')
