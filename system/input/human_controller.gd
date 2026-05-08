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

@export var abrir_menu_action := "abrir_menu"

var parent:Node2D


func _ready() -> void:
	parent = get_parent()
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	update_process()

func update_process():
	if active:
		process_mode = Node.PROCESS_MODE_ALWAYS  # ← cambia INHERIT por ALWAYS
	else:
		process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
	parent.move_vector = Input.get_vector(action_left,action_right,action_up,action_down)

	if Input.is_action_just_pressed(abrir_menu_action): 
		print("presionado menu")
		toggle_menu()


func toggle_menu():
	GameManager.toggle_menu()
