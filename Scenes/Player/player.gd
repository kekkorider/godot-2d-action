extends CharacterBody2D

@export_range(0, 1000, 10) var speed := 60.0

@onready var sprite := $AnimatedSprite2D

func _ready() -> void:
    position = Game.player_spawn_position

func _process(_delta: float) -> void:
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

  move_and_slide()
