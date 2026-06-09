extends CanvasLayer

@export var label_recomendacion: Label
@export var boton_aceptar_recomendacion: Button

const TIPS = [
	"HABLAR   CON   TODOS   LOS   NPCs
PUEDE   REVELAR   MISIONES
SECRETAS.   
NO   TE   LOS   SALTES!!",
	"CADA   NPC   TIENE   ALGO   
QUE   CONTAR...   
HABLA   CON   TODOS.",
	"HABLA   CON   CADA   NPC:
DESBLOQUEARÁS   DIÁLOGOS
Y   MISIONES   OCULTAS",
	"INTERACTÚA   CON   CADA   NPC.
SUS   PALABRAS   PUEDEN
CAMBIAR   TU   DESTINO.",
	"HABLA   CON   TODOS   LOS   NPCs.
NO   SABES   QUÉ   MISIONES   O
SECRETOS   ESCONDEN.",
]

func _ready() -> void:
	if label_recomendacion:
		label_recomendacion.text = TIPS[randi() % TIPS.size()]
	if boton_aceptar_recomendacion:
		boton_aceptar_recomendacion.pressed.connect(carambolas)
func carambolas():
	_cambiar_escena(true)

func _cambiar_escena(escena: bool):
	#controlador_partida.borrar_partida()
	if escena == true:
		get_tree().change_scene_to_file("res://main.tscn")
