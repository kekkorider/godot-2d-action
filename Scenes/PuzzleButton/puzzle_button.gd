extends Area2D

signal pressed
signal unpressed

var bodies_on_top := 0

@export var is_single_use := false

@onready var sprite := $AnimatedSprite2D

func _on_body_entered(body: Node2D) -> void:
  if body.is_in_group('pushable') or body is Player:
    bodies_on_top += 1

  if bodies_on_top == 1:
    sprite.play('pressed')
    pressed.emit()

func _on_body_exited(body: Node2D) -> void:
  if is_single_use:
    return

  if body.is_in_group('pushable') or body is Player:
    bodies_on_top -= 1

    if bodies_on_top == 0:
      sprite.play('unpressed')
      unpressed.emit()
