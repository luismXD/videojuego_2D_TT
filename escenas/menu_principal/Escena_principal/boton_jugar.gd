extends Button



func _ready():
	pressed.connect(_jugar)

func _jugar():
	get_tree().change_scene_to_file("res://escenas/menu_principal/menu_jugar/escena_menu_jugar.tscn")
