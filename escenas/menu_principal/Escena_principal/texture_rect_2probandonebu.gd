extends Control

func _ready():
	crear_fondo_gradiente()
	crear_nebulosa()

func crear_fondo_gradiente():
	# Tu fondo gradiente existente
	var fondo = TextureRect.new()
	fondo.anchor_right = 1.0
	fondo.anchor_bottom = 1.0
	fondo.size = Vector2.ZERO
	fondo.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	
	var gradient = Gradient.new()
	gradient.colors = [Color("#3c3834"), Color("#2a2623")]
	
	var gradient_texture = GradientTexture2D.new()
	gradient_texture.gradient = gradient
	#gradient_texture.fill = GradientTexture2D.FILL_LINEAR_VERTICAL
	#
	fondo.texture = gradient_texture
	add_child(fondo)
	move_child(fondo, 0)

func crear_nebulosa():
	# Crear la nebulosa
	var nebulosa = TextureRect.new()
	nebulosa.anchor_right = 0.5  # Centrar horizontalmente
	nebulosa.anchor_bottom = 0.5  # Centrar verticalmente
	nebulosa.position = Vector2(-150, -100)  # Ajusta posición
	nebulosa.size = Vector2(400, 300)  # Tamaño de la mancha
	
	# Crear textura circular difusa
	var imagen = crear_textura_circular_suave()
	nebulosa.texture = imagen
	nebulosa.modulate = Color("#5a4a3f")  # Color con opacidad
	nebulosa.modulate.a = 0.15  # Opacidad baja (15%)
	
	add_child(nebulosa)

func crear_textura_circular_suave() -> ImageTexture:
	var size = 512
	var image = Image.create(size, size, false, Image.FORMAT_RGBA8)
	
	for x in range(size):
		for y in range(size):
			var dx = (x - size/2.0) / (size/2.0)
			var dy = (y - size/2.0) / (size/2.0)
			var distancia = sqrt(dx*dx + dy*dy)
			
			# Gradiente suave circular
			var alpha = max(0, 1.0 - distancia)  # Transparencia
			alpha = alpha * alpha  # Suavizar
			alpha = alpha * 0.8    # Opacidad máxima 80%
			
			var color = Color(1, 1, 1, alpha)
			image.set_pixel(x, y, color)
	
	return ImageTexture.create_from_image(image)
