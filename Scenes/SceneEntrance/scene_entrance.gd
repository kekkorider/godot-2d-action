extends Area2D

@export var next_scene: String

func _on_body_entered(_body: Node2D) -> void:
    get_tree().change_scene_to_file.call_deferred(next_scene)

func _on_body_exited(_body: Node2D) -> void:
    print('exit')
