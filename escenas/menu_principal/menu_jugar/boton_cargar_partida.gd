extends Button

@export var icon_izq: TextureRect
@export var icon_der: TextureRect

func _ready():
	
	pressed.connect(_jugar)
	


func _jugar():
	var correo_electronico =  ControladorPartidaGlobal.partida.jugador["correo_electronico"]
	ControladorPartidaGlobal.cargar_partida()

	print(correo_electronico)
