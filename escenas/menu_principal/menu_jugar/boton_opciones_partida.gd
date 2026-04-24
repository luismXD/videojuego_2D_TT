extends Button



func _ready():

	ready
	pressed.connect(_menu_usuario)
	

func _menu_usuario():
	get_tree().change_scene_to_file("res://escenas/menu_principal/opciones_usuario/menu_opciones_usuario.tscn")
