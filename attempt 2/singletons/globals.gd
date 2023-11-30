extends Node

var coins := 0 
var score := 0 
var player_life := 3 
var highscore := 0
var lastscore := 0
var scoreId


var timer

func _ready():
	timer = get_tree().create_timer(10)
	timer.timeout.connect(Callable(self, "_on_Timer_timeout"))

func collect_coin():
	coins += 1
	if coins == 10:
		score += 100
		coins = 0
	if score > highscore:
			highscore = score
			
var player = null
 
var player_start_position 

var current_checkpoint = null

func respawn_player():
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position
	else:
		player.global_position = player_start_position.global_position 

func _process(delta):
	if highscore != lastscore:
		print("Current Highscore:", highscore)
		lastscore = highscore
		

#func _on_Timer_timeout():
#	print("Current Highscore:", highscore)
#	timer = get_tree().create_timer(10)
#	timer.timeout.connect(Callable(self, "_on_Timer_timeout"))
