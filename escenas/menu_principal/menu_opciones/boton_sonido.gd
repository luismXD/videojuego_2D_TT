extends Button

#boton opciones
@export var popup_sonido: CanvasLayer
@export var panel_popup_sonido: PanelContainer

@export var boton_salir:Button

@export var barra_sonido_ajuste: HSlider
@export var progress_bar_sonido: ProgressBar

@export var subviewport_container: SubViewportContainer


func _ready():
	if popup_sonido:
		popup_sonido.hide()

	if subviewport_container:
		subviewport_container.mouse_filter = Control.MOUSE_FILTER_IGNORE

	pressed.connect(_on_pressed_sonido)
	
	if boton_salir:
		boton_salir.pressed.connect(_on_pressed_salir)

	barra_sonido_ajuste.value = ControladorPartidaGlobal.partida.jugador["volumen"]
	progress_bar_sonido.value = barra_sonido_ajuste.value

	if barra_sonido_ajuste:
		barra_sonido_ajuste.value_changed.connect(_on_barra_sonido_ajuste_value_changed)



func _on_pressed_sonido():
	if popup_sonido:
		popup_sonido.show()

	if subviewport_container:
		subviewport_container.mouse_filter = Control.MOUSE_FILTER_STOP

func _on_pressed_salir():
	if popup_sonido:
		popup_sonido.hide()

	if subviewport_container:
		subviewport_container.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_barra_sonido_ajuste_value_changed(value: float) -> void:
	print("Valor de la barra de sonido: ", value + 100)
	progress_bar_sonido.value = value
	ControladorPartidaGlobal.partida.jugador["volumen"] = value
	ControladorPartidaGlobal.guardar_partida()
	barra_sonido(value)

func barra_sonido(valor: float):
	GameManager.set_volumen(valor)
