extends CharacterBody2D

class_name Player

@export_range(0, 1000, 10) var speed := 60.0
@export_range(0, 500, 5) var push_strength := 180.0
@export_range(0, 300, 5) var knockback_strength := 200.0
@export_range(0, 10, 0.5) var acceleration := 5.0

@onready var sprite := $AnimatedSprite2D
@onready var interaction_area := $InteractionArea
@onready var treasure_label := %TreasureLabel
@onready var life_sprite := %LifeSprite
@onready var sword := $Sword
@onready var sword_area := %SwordArea2D
@onready var anim_player := $AnimationPlayer
@onready var damage_sfx := $DamageSFX
@onready var sword_sfx := $SwordSFX

var is_attacking := false

func _ready() -> void:
  position = Game.player_spawn_position

func _physics_process(_delta: float) -> void:
  if Game.player_hp <= 0:
    return

  if not is_attacking: move_player()

  push_blocks()

  if Input.is_action_just_pressed("action") and not interaction_area.has_overlapping_bodies():
    attack()

  move_and_slide()

  treasure_label.text = str(Game.opened_chests.size())

func move_player() -> void:
  var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
  velocity = velocity.move_toward(direction * speed, acceleration)

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

func _on_hitbox_body_entered(body: CharacterBody2D) -> void:
  if Game.player_hp <= 0:
    return

  Game.player_hp -= 1

  damage_sfx.play()

  anim_player.play('flash')

  update_hp_bar()

  if Game.player_hp <= 0:
    die()
  else:
    var direction_to_player := body.global_position.direction_to(global_position)
    velocity += 150 * direction_to_player

func attack() -> void:
  if is_attacking: return

  is_attacking = true

  velocity = Vector2.ZERO

  sword.visible = true
  sword_area.monitoring = true

  sword_sfx.play()

  var player_animation: String = sprite.animation

  if player_animation == 'move_left':
    sprite.play('attack_left')
    anim_player.play('attack_left')
  elif player_animation == 'move_right':
    sprite.play('attack_right')
    anim_player.play('attack_right')
  elif player_animation == 'move_up':
    sprite.play('attack_up')
    anim_player.play('attack_up')
  elif player_animation == 'move_down':
    sprite.play('attack_down')
    anim_player.play('attack_down')

  await get_tree().create_timer(0.35).timeout

  sprite.play(player_animation)
  sword.visible = false
  sword_area.monitoring = false
  is_attacking = false

func die() -> void:
  sprite.play('death')

  await get_tree().create_timer(1.0).timeout

  get_tree().call_deferred('reload_current_scene')
  Game.player_hp = 3

func _on_sword_body_entered(body: Node2D) -> void:
  body.hit(self)
