extends CanvasLayer

@export var panel: PanelContainer
@export var label_puntos: Label

var _timer: Timer
var _puntos := 0
var _ruta_escena := ""

func _ready():
	hide()

func mostrar_y_cargar(ruta: String):
	_ruta_escena = ruta
	show()
	_puntos = 0
	label_puntos.text = "."
	_timer = Timer.new()
	add_child(_timer)
	_timer.wait_time = 0.3
	_timer.timeout.connect(_tick)
	_timer.start()
	ResourceLoader.load_threaded_request(ruta)

func _tick():
	# Actualiza puntos
	_puntos = (_puntos + 1) % 4
	label_puntos.text = ".".repeat(max(_puntos, 1))
	
	# Revisa si ya cargó
	var status = ResourceLoader.load_threaded_get_status(_ruta_escena)
	if status == ResourceLoader.THREAD_LOAD_LOADED:
		var escena = ResourceLoader.load_threaded_get(_ruta_escena)
		_timer.stop()
		_timer.queue_free()
		_timer = null
		hide()
		get_tree().change_scene_to_packed(escena)

func _ocultar():
	if _timer:
		_timer.stop()
		_timer.queue_free()
		_timer = null
	hide()





#
#extends CanvasLayer
#
#@onready var panel: PanelContainer = $PanelContainer
#@onready var label_puntos: Label = $PanelContainer/Label
#
#var _timer: Timer
#var _puntos := 0
#var _ruta_escena := ""
#
#func _ready():
	#hide()
#
#func mostrar_y_cargar(ruta: String):
	#_ruta_escena = ruta
	#show()
	#_puntos = 0
	#label_puntos.text = ""
	#_timer = Timer.new()
	#add_child(_timer)
	#_timer.wait_time = 0.5
	#_timer.timeout.connect(_actualizar_puntos)
	#_timer.start()
	#ResourceLoader.load_threaded_request(ruta)
	#set_process(true)
#
#func _process(_delta):
	#var status = ResourceLoader.load_threaded_get_status(_ruta_escena)
	#if status == ResourceLoader.THREAD_LOAD_LOADED:
		#set_process(false)
		#var escena = ResourceLoader.load_threaded_get(_ruta_escena)
		#_ocultar()
		#get_tree().change_scene_to_packed(escena)
#
#func _ocultar():
	#if _timer:
		#_timer.stop()
		#_timer.queue_free()
		#_timer = null
	#hide()
#
#func _actualizar_puntos():
	#_puntos = (_puntos + 1) % 4
	#label_puntos.text = ".".repeat(_puntos)
