extends Button

@export var icon_izq: TextureRect
@export var icon_der: TextureRect


func _ready():
	pressed.connect(_quitar_juego)
	


func _quitar_juego():
	get_tree().quit()
