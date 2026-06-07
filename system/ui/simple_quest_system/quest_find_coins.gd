class_name Quest extends QuestManager
 
func start_quest() -> void:
	if quest_status == QuestStatus.available:
		quest_status = QuestStatus.started
		if QuestTitle:
			QuestTitle.text = quest_name
		if QuestDescription:
			QuestDescription.text = quest_description
		_mostrar_panel()  # ✅ anima la entrada
 
func reached_goal() -> void:
	if quest_status == QuestStatus.started:
		quest_status = QuestStatus.reached_goal
		if QuestDescription:
			QuestDescription.text = reached_goal_text
 
func finish_quest() -> void:
	if quest_status == QuestStatus.reached_goal:
		quest_status = QuestStatus.finished
		_ocultar_panel()  # ✅ anima la salida
		GameManager.gold += reward_amount
		GameManager.xp += xp_amount
 
