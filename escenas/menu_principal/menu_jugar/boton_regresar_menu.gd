extends Button

@export var icon_izq: TextureRect
@export var icon_der: TextureRect


func _ready():
	
	pressed.connect(_jugar)


func _jugar():
	get_tree().change_scene_to_file("res://escenas/menu_principal/Escena_principal/menu_principal.tscn")
