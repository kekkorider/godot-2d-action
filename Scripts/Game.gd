extends Node

var player_spawn_position: Vector2
var player_can_interact := false

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("quit"):
        get_tree().quit()
    elif event.is_action_pressed("restart"):
        get_tree().reload_current_scene()
