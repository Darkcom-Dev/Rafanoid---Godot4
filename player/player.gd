extends CharacterBody2D

class_name Player

@export var speed : int = 4
var is_started : bool = false
@export_node_path("CollisionObject2D") var ball_node_path 
@onready var ball = get_node(ball_node_path)
@onready var gift_s : AudioStreamPlayer2D = $gift
@onready var spr_player : AnimatedSprite2D = $spr_player
@onready var col_player : CollisionShape2D = $col_player
@onready var timer : Timer = $powerup_timer

@onready var parent = get_parent()
func _ready() -> void:
	GLOBALS.gift_picked.connect(_on_gift_gift_picked)
	print('ball parent: ' + ball.get_parent().name)
	
	# Pega la bola del player
	if ball.get_parent().name == "World":
		ball.reparent.call_deferred(get_node(get_path()))
		print('-----------------')
		print('ball position: ' + str(ball.position))
		print('ball parent: ' + ball.get_parent().name)

func enable_powerup() -> void:
	gift_s.play()
	spr_player.frame = 1
	col_player.shape.size.x = 72
	timer.start()

func disable_powerup() -> void:
	spr_player.frame = 0
	col_player.shape.size.x = 64

func _on_player_powerup_timer_timeout():
	disable_powerup()

func _on_gift_gift_picked():
	enable_powerup()

func _input(event):
	if event.is_action_pressed("Aceptar") and not is_started:
		is_started = 1

	# Despega la bola del player
	if is_instance_valid(ball):
		if is_started:
			ball.reparent(parent)

func _physics_process(_delta):

	if Input.is_action_pressed("Derecha"):
		var movement : Vector2 = Vector2(speed,0)
		move_and_collide(movement)
		
	if Input.is_action_pressed("Izquierda"):
		var movement : Vector2 = Vector2(-speed,0)
		move_and_collide(movement)
	
