extends CanvasLayer

@export var pantalla_cargando: CanvasLayer
@export var label_puntos: Label

var puntos = 0
var timer_cargando: Timer

func _ready():
	_iniciar_animacion_cargando()

func _iniciar_animacion_cargando():
	pantalla_cargando.show()

	timer_cargando = Timer.new()
	add_child(timer_cargando)
	timer_cargando.wait_time = 0.5
	timer_cargando.timeout.connect(_actualizar_puntos)
	timer_cargando.start()

func _actualizar_puntos():
	puntos = (puntos + 1) % 4
	label_puntos.text = ".".repeat(puntos)

func _detener_animacion_cargando():
	if timer_cargando:
		timer_cargando.stop()
		timer_cargando.queue_free()  # limpia el nodo, no solo lo pausa
		timer_cargando = null
	pantalla_cargando.hide()
