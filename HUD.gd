extends CanvasLayer

signal start_game

func show_message(msg):
	get_node("MessageLabel").text = msg
	get_node("MessageLabel").show()
	get_node("MessageTimer").start()

func show_game_over():
	show_message("Ya Got \nSneezed on!")
	yield(get_node("MessageTimer"), "timeout")
	get_node("MessageLabel").text = "Dodge \nCovid-19"
	get_node("MessageLabel").show()
	
	yield(get_tree().create_timer(1), "timeout")
	get_node("StartButton").show()

func update_score(score):
	get_node("ScoreLabel").text = str(score)
	
func _on_StartButton_pressed():
	get_node("StartButton").hide()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	get_node("MessageLabel").hide()
