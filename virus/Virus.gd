extends RigidBody2D

export var virus_speed  = 250

func _ready():
	pass

func _on_Visiblity_screen_exited():
	queue_free()

func _on_start_game():
	queue_free()
