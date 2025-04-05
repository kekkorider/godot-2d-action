extends StaticBody2D

@export var buttons_needed := 1

@onready var buttons_pressed := 0
@onready var collision_shape := $CollisionShape2D

func _on_puzzle_button_pressed() -> void:
  buttons_pressed += 1

  if buttons_pressed >= buttons_needed:
    visible = false
    collision_shape.set_deferred('disabled', true)


func _on_puzzle_button_unpressed() -> void:
  buttons_pressed -= 1

  if buttons_pressed < buttons_needed:
    visible = true
    collision_shape.set_deferred('disabled', false)
