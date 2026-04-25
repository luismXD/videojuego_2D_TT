extends Button

@export var icon_izq: TextureRect
@export var icon_der: TextureRect


func _ready():
	pressed.connect(_menu_opciones)


func _menu_opciones():
	get_tree().change_scene_to_file("res://escenas/menu_principal/menu_opciones/escena_menu_opciones.tscn")
