extends Node
class_name HumanController


@export var active := true:
	set(v):
		active = v
		update_process()

@export var action_left := "izquierda"
@export var action_right := "derecha"
@export var action_up := "arriba"
@export var action_down := "abajo"

var parent:Node2D


func _ready() -> void:
	parent = get_parent()
	update_process()


func update_process():
	if active:
		process_mode = Node.PROCESS_MODE_INHERIT
	else:
		process_mode = Node.PROCESS_MODE_DISABLED


func _process(delta: float) -> void:
	parent.move_vector = Input.get_vector(action_left,action_right,action_up,action_down)
