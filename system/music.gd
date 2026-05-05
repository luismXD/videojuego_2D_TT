extends AudioStreamPlayer


signal music_stopped

const VOLUME_MIN = -60
var VOLUME_MORMAL =  ControladorPartidaGlobal.partida.jugador["volumen"]

var tween:Tween

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	GameManager.volumen_cambiado.connect(_on_volumen_cambiado)


func _on_volumen_cambiado(valor: float) -> void:
	VOLUME_MORMAL = valor
	volume_db = valor

func change_music(audio_stream:AudioStream):
	if stream:
		if stream == audio_stream:
			return
		await stop_music()
	play_music(audio_stream)


func play_music(audio_stream:AudioStream):
	stream = audio_stream
	volume_db = VOLUME_MORMAL
	play()


func stop_music(time = 1):
	if !time:
		stream = null
	else:
		tween = create_tween()
		tween.tween_property(self,"volume_db",VOLUME_MIN,time)
		await tween.finished
		music_stopped.emit()
		stream = null
