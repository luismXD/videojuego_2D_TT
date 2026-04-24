extends Control

func _ready():
	crear_luna_con_luz()

func crear_luna_con_luz():
	# 1. Capa de luz (detrás de la luna)
	var luz = TextureRect.new()
	luz.size = Vector2(300, 300)
	luz.position = Vector2(750, 20)  # Ajusta según tu luna
	
	# Gradiente radial para la luz
	var gradient = Gradient.new()
	gradient.colors = [
		Color("#FFE8C8", 0.4),  # Centro brillante
		Color("#FFD8A0", 0.15), # Medio
		Color(1, 1, 1, 0)       # Borde transparente
	]
	gradient.offsets = [0.0, 0.4, 1.0]
	
	var gradient_texture = GradientTexture2D.new()
	gradient_texture.gradient = gradient
	gradient_texture.fill = 2  # Radial
	
	luz.texture = gradient_texture
	add_child(luz)
	
	# 2. Tu luna PNG
	var luna = TextureRect.new()
	luna.texture = load("res://temas_y_estilos/menu_assets_nuevos/imagenes_menu/moon.png")
	luna.size = Vector2(150, 150)
	luna.position = Vector2(825, 95)  # Centrada con la luz
	luna.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	add_child(luna)
