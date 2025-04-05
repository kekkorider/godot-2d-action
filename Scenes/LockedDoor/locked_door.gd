extends StaticBody2D

@onready var collision_shape := $CollisionShape2D

func _on_puzzle_button_pressed() -> void:
  visible = false
  collision_shape.set_deferred('disabled', true)


func _on_puzzle_button_unpressed() -> void:
  visible = true
  collision_shape.set_deferred('disabled', false)
