extends TileMapLayer

func disable_wall() -> void:
  visible = false
  collision_enabled = false

func enable_wall() -> void:
  visible = true
  collision_enabled = true
