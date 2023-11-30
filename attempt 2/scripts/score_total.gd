extends Label



func _ready():
	text = str(Globals.lastscore)

func update_score(score: int):
	text = str(score)
