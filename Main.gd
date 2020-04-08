extends Node

export (PackedScene) var Virus = preload("res://virus/Virus.tscn")
var score

func _ready():
	randomize()
	
func game_over():
	get_node("ScoreTimer").stop()
	get_node("VirusTimer").stop()
	get_node("BackGroud").stop()
	get_node("DeadSound").play()
	get_node("HUD").show_game_over()
	
func new_game():
	score = 0
	get_node("HUD").update_score(score)
	get_node("HUD").show_message("Get Ready !")
	get_node("Player").start(get_node("StartPosition").position)
	get_node("StartTimer").start()
	get_node("BackGroud").play()
	
func _on_StartTimer_timeout():
	get_node("ScoreTimer").start()
	get_node("VirusTimer").start()
	
func _on_ScoreTimer_timeout():
	score += 1
	get_node("HUD").update_score(score)
	
func _on_VirusTimer_timeout():
	var enemies = get_tree().get_nodes_in_group("baddies")
	var direction = get_node("Path2D/VirusPath").rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	
	for enemy in enemies:
		enemy.linear_velocity = enemy.linear_velocity.rotated(direction)
	get_node("Path2D/VirusPath").offset = randi()
	var virus = Virus.instance()
	add_child(virus)
	
	virus.position = get_node("Path2D/VirusPath").position
	virus.linear_velocity = Vector2(virus.virus_speed, 0)
	virus.linear_velocity = virus.linear_velocity.rotated(direction)
	get_node("HUD").connect("start_game", virus, "_on_start_game")


func _on_HUD_start_game():
	new_game()


func _on_Player_hit():
	game_over()
