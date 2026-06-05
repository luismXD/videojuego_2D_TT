extends Area2D

@export var spawn_point: Marker2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.set_deferred("global_position", spawn_point.global_position)
