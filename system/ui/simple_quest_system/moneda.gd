extends Area2D
 
var quest: Quest
var _frame: int = 0
var _timer: float = 0.0
var FRAME_DURATION: float = 0.08  # segundos por frame (~12fps)
 
@onready var sprite: Sprite2D = $CoinSpritesheet
 
func _process(delta: float) -> void:
	_timer += delta
	if _timer >= FRAME_DURATION:
		_timer = 0.0
		_frame = (_frame + 1) % 16
		sprite.frame = _frame
 
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		quest.reached_goal()
		queue_free()
