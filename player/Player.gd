extends Area2D

export var speed = 400
var screen_size
signal hit

func _ready():
	screen_size =  get_viewport_rect().size
	#hide()

func _process(delta):
	var velocity =  Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		get_node("AnimatedSprite").play()
	else:
		get_node("AnimatedSprite").stop()
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		get_node("AnimatedSprite").flip_h = velocity.x < 0
		get_node("AnimatedSprite").flip_v = false
	if velocity.y != 0:
		get_node("AnimatedSprite").flip_h = false
		get_node("AnimatedSprite").flip_v = velocity.y > 0

func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	get_node("CollisionShape2D").set_deferred("disabled", true)
	
func start(start_position):
	position = start_position
	show()
	get_node("CollisionShape2D").disabled = false
