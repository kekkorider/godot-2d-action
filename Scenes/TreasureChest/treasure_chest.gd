extends StaticBody2D

@export var chest_id: String

@onready var sprite := $AnimatedSprite2D
@onready var loot_sprite := $LootSprite
@onready var anim_player := $AnimationPlayer

var can_interact := false
var is_open := false

func _ready() -> void:
	if Game.opened_chests.has(chest_id):
		is_open = true
		sprite.play('open')

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('action') && can_interact && !is_open:
		Game.opened_chests.append(chest_id)
		print(Game.opened_chests)

		is_open = true
		sprite.play('open')

		loot_sprite.visible = true
		anim_player.play('animate_in')
