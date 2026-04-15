extends Button

@export var icon_izq: TextureRect
@export var icon_der: TextureRect


func _ready():
	mouse_entered.connect(_mostrar_iconos)
	mouse_exited.connect(_ocultar_iconos)
	
	pressed.connect(_jugar)
	
	_ocultar_iconos()

func _jugar():
	get_tree().change_scene_to_file("res://escenas/menu_principal/menu_jugar/escena_menu_jugar.tscn")

func _mostrar_iconos():
	icon_izq.visible = true
	icon_der.visible = true

func _ocultar_iconos():
	icon_izq.visible = false
	icon_der.visible = false
