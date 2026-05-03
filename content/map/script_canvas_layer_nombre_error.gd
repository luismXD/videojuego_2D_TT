extends CanvasLayer

func _ready() -> void:
	GameManager.menu_toggled.connect(_on_menu_toggled)
	visible = false

func _on_menu_toggled(abierto: bool) -> void:
	visible = abierto

func _on_reanudar_pressed() -> void:
	GameManager.toggle_menu()
