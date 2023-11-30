extends Control
@export var _ranking_container: VBoxContainer = null

func _ready():
	var _sw_result: Dictionary = await SilentWolf.Scores.get_scores().sw_get_scores_complete
#	print("Scores: " + str(_sw_result.scores))

	var _index: int = 0
	
	for _slot in _ranking_container.get_children():
		if _slot is Label:
			continue
		_slot.hide()

	for _slot in _ranking_container.get_children():
		if _slot is Label:
			continue
		
		if _sw_result.scores.size() > _index:
			_slot.get_node("position").text =str(_index + 1) + ". "
			_slot.get_node("name").text = _sw_result.scores[_index] ["player_name"]
			_slot.get_node("score").text = "  "  + str(_sw_result.scores[_index] ["score"])
			_slot.show()
			
		_index +=1


func _on_voltar_pressed():
	get_tree().change_scene_to_file("res://prefabs/menu.tscn")
