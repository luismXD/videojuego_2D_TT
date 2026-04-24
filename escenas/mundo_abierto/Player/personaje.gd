extends CharacterBody2D



#animcacion correr, puede ser Node mas sencillo
@export var animacion: AnimatedSprite2D
var ultimo_movimiento: int = 0
#@export var area_2d: Area2D

var _velocidad: float = 100.0
func  _physics_process(delta):
	#animacion

	#gravedad
	var direccion := Input.get_vector("move_left","move_right","move_up","move_down")

	velocity = direccion * _velocidad
	#movimientos
	if direccion.x > 0:
		animacion.flip_h = false
		ultimo_movimiento = 1
	elif direccion.x < 0:
		animacion.flip_h = true
		ultimo_movimiento = 2
	elif direccion.y < 0:
		ultimo_movimiento = 3
	elif direccion.y > 0:
		ultimo_movimiento = 0
	move_and_slide()



	# Lógica de animación
	if direccion.length() > 0:  # Si se está moviendo
		if abs(direccion.x) > abs(direccion.y):
			# Movimiento horizontal
			animacion.play("caminar_x")
		else:
			# Movimiento vertical
			if direccion.y < 0:
				animacion.play("caminar_arriba")
				
			else:
				animacion.play("caminar_abajo")
	else:

		# Quieto
		if ultimo_movimiento == 0:
			animacion.play("idle")
		elif ultimo_movimiento == 1:
			#animacion.flip_
			animacion.flip_h = false
			animacion.play("idle_x")
		elif ultimo_movimiento == 2:
			animacion.flip_h = true
			animacion.play("idle_x")
		elif ultimo_movimiento == 3:
			animacion.play("idle_y")
