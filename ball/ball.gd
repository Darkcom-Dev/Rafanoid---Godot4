extends RigidBody2D

var is_started : int = 0
var is_paused : bool = false
var replay_scene = preload("res://replay_menu.tscn")
var pause_scene = preload("res://pause_menu.tscn")
var win_scene = preload("res://win_menu.tscn")

var gift_scene = ResourceLoader.load("res://gift/gift.tscn")
var explosion_scene = ResourceLoader.load('res://enviroment/block_explosion.tscn')


@onready var break_s : AudioStreamPlayer2D = get_node('break')
@onready var start_s : AudioStreamPlayer2D = get_node('start')
@onready var hit_s : AudioStreamPlayer2D = get_node('hit')


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame, even when the engine detects no input.
func _input(event):
	
	if is_started == 1: 
		linear_velocity = Vector2(50,-200)
		start_s.play()
		is_started = 2
	
	if event.is_action_pressed("Aceptar") and is_started == 0:
		is_started = 1
	
	if event.is_action_pressed("Pause"):
		get_tree().paused = true
		get_parent().add_child(pause_scene.instantiate())
		
		
func _physics_process(_delta):
	
	for body in get_colliding_bodies():
		
		if body.is_in_group("gr_blocks"):
			body.queue_free()
			break_s.play()
			

					
			if body.get_parent().get_child_count() == 1:
				print("GANASTE")
				get_tree().paused = true
				queue_free()
				get_parent().add_child(win_scene.instantiate())
				
			elif body.get_parent().get_child_count() > 2:
				# Generar explosion
				var explosion = explosion_scene.instantiate()
				body.get_parent().add_child(explosion)
				explosion.position = body.position	
			
				# Generar regalo
				if randi() % 9 == 0:
					var gift = gift_scene.instantiate()
					body.get_parent().add_child(gift)
					gift.position = body.position
					print('Instanciar regalo')

		else:
			hit_s.play()

func _on_visible_on_screen_notifier_2d_screen_exited():
	get_tree().paused = true
	queue_free()	
	get_parent().add_child(replay_scene.instantiate())
