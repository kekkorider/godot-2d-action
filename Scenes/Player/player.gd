extends CharacterBody2D

class_name Player

@export_range(0, 1000, 10) var speed := 60.0
@export_range(0, 500, 5) var push_strength := 180.0

@onready var sprite := $AnimatedSprite2D

func _ready() -> void:
    position = Game.player_spawn_position

func _physics_process(_delta: float) -> void:
  var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
  velocity = direction * speed

  if velocity.x < 0:
    sprite.play("move_left")
  elif velocity.x > 0:
    sprite.play("move_right")
  elif velocity.y < 0:
    sprite.play("move_up")
  elif velocity.y > 0:
    sprite.play("move_down")
  else:
    sprite.stop()

  push_blocks(get_last_slide_collision())

  move_and_slide()

func push_blocks(collision: KinematicCollision2D) -> void:
  if collision:
    var node: Node2D = collision.get_collider()

    if node.is_in_group('pushable'):
      var normal: Vector2 = collision.get_normal()
      node.apply_central_force(normal * push_strength * -1)
