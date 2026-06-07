class_name QuestManager extends Node2D
 
var QuestBox: CanvasLayer
var QuestTitle: RichTextLabel
var QuestDescription: RichTextLabel
var _panel: Control  # el panel que se desliza
 
@export_group("Quest Settings")
@export var quest_name: String
@export var quest_description: String
@export var reached_goal_text: String
 
enum QuestStatus {
	available,
	started,
	reached_goal,
	finished,
}
 
@export var quest_status: QuestStatus = QuestStatus.available
 
@export_group("Reward Settings")
@export var reward_amount: int
@export var xp_amount: int
 
func _ready() -> void:
	var misions = get_tree().get_first_node_in_group("misions_ui")
	if misions:
		QuestBox         = misions.get_node("QuestBox")
		QuestTitle       = misions.get_node("QuestBox/QuestTitle")
		QuestDescription = misions.get_node("QuestBox/QuestDescription")
		_panel = misions.get_node_or_null("QuestBox/PanelMision")
	else:
		push_error("[QuestManager] No encontré nodo con grupo 'misions_ui'")
 
func _mostrar_panel() -> void:
	if not QuestBox:
		return
	QuestBox.visible = true
	if _panel:
		_panel.position.x = -400
		var tween = create_tween()
		tween.tween_property(_panel, "position:x", 0.0, 0.4)\
			.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
 
func _ocultar_panel() -> void:
	if not QuestBox or not _panel:
		if QuestBox:
			QuestBox.visible = false
		return
	var tween = create_tween()
	tween.tween_property(_panel, "position:x", -400.0, 0.3)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	QuestBox.visible = false
