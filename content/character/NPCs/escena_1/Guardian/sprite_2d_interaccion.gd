extends Sprite2D

func _ready() -> void:
	hide()
	GameManager.jugador_en_rango.connect(show)
	GameManager.jugador_salio_de_rango.connect(hide)
