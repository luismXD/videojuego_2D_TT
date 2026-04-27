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

#@export var canvas_layer_path := NodePath("Panel")
#

#res://escenas/menu_principal/Escena_principal/menu_principal.tscn

#@onready var canvas_layer = get_tree().get_first_node_in_group("escena_menu_pene")

var parent:Node2D


func _ready() -> void:
	#if canvas_layer:
		#canvas_layer.visible = false
	#
	parent = get_parent()
	update_process()


func update_process():
	if active:
		process_mode = Node.PROCESS_MODE_INHERIT
	else:
		process_mode = Node.PROCESS_MODE_DISABLED


func _process(delta: float) -> void:
	parent.move_vector = Input.get_vector(action_left,action_right,action_up,action_down)

	if Input.is_action_just_pressed(abrir_menu_action): 
		print("presionado menu")
		toggle_menu()


func toggle_menu():
	#var canvas_layer = get_tree().get_first_node_in_group("escena_menu_pene")
	#
	#if canvas_layer:
		#canvas_layer.visible = not canvas_layer.visible
		#print("Menú visible:", canvas_layer.visible)
	#else:
		#print("NO encontró el menú")
	#get_tree().change_scene_to_file("res://escenas/menu_principal/Escena_principal/menu_principal.tscn")
	GameManager.toggle_menu()
