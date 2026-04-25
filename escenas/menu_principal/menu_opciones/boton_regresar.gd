extends Button

@export var icon_izq: TextureRect
@export var icon_der: TextureRect

func _ready():
	pressed.connect(_regresar_menu_principal)
	

func _regresar_menu_principal():
	get_tree().change_scene_to_file("res://escenas/menu_principal/Escena_principal/menu_principal.tscn")

func borrar_datos():
	ControladorPartidaGlobal.borrar_datos()
	
