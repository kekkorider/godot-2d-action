extends CharacterBody2D

@export_range(0, 1000, 10) var speed := 30.0
@export_range(0, 10, 0.5) var acceleration := 5.0
@export_range(1, 10, 1) var hp := 2

@onready var sprite := $AnimatedSprite2D
@onready var anim_player := $AnimationPlayer

var target: Node2D
var direction_to_player := Vector2.ZERO

func _physics_process(_delta: float) -> void:
  chase_target()
  animate_enemy()

  move_and_slide()

func chase_target() -> void:
  if not target:
    return

  direction_to_player = global_position.direction_to(target.global_position)
  velocity = velocity.move_toward(direction_to_player * speed, acceleration)

func animate_enemy() -> void:
  if not target:
    return

  var threshold := 0.707

  if direction_to_player.x > threshold:
    sprite.play("move_right")
  elif direction_to_player.x < -threshold:
    sprite.play("move_left")
  elif direction_to_player.y > threshold:
    sprite.play("move_down")
  elif direction_to_player.y < -threshold:
    sprite.play("move_up")

func _on_detection_area_body_entered(body: Node2D) -> void:
  if not body is Player:
    return

  target = body

func _on_detection_area_body_exited(body: Node2D) -> void:
  if not body is Player:
    return

  target = null
  velocity = Vector2.ZERO
  sprite.stop()
