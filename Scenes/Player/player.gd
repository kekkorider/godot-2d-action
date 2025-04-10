extends CharacterBody2D

class_name Player

@export_range(0, 1000, 10) var speed := 60.0
@export_range(0, 500, 5) var push_strength := 180.0

@onready var sprite := $AnimatedSprite2D
@onready var interaction_area := $InteractionArea
@onready var treasure_label := %TreasureLabel
@onready var life_sprite := %LifeSprite

func _ready() -> void:
  position = Game.player_spawn_position

func _physics_process(_delta: float) -> void:
  move_player()

  push_blocks()

  move_and_slide()

  treasure_label.text = str(Game.opened_chests.size())

func move_player() -> void:
  var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
  velocity = direction * speed

  if velocity.x < 0:
    sprite.play("move_left")
    interaction_area.position = Vector2(-5, 2)
  elif velocity.x > 0:
    sprite.play("move_right")
    interaction_area.position = Vector2(5, 2)
  elif velocity.y < 0:
    sprite.play("move_up")
    interaction_area.position = Vector2(0, -4)
  elif velocity.y > 0:
    sprite.play("move_down")
    interaction_area.position = Vector2(0, 8)
  else:
    sprite.stop()


func push_blocks() -> void:
  var collision := get_last_slide_collision()

  if collision:
    var node: Node2D = collision.get_collider()

    if node.is_in_group('pushable'):
      var normal: Vector2 = collision.get_normal()
      node.apply_central_force(normal * push_strength * -1)

func update_hp_bar() -> void:
  life_sprite.frame = Game.player_hp

func _on_interaction_area_entered(body: Node2D) -> void:
  if body.is_in_group('interactable'):
    body.can_interact = true

func _on_interaction_area_exited(body: Node2D) -> void:
  if body.is_in_group('interactable'):
    body.can_interact = false

func _on_hitbox_body_entered(_body: CharacterBody2D) -> void:
  Game.player_hp -= 1

  update_hp_bar()

  if Game.player_hp <= 0: die()

func die() -> void:
  get_tree().call_deferred('reload_current_scene')
  Game.player_hp = 3
