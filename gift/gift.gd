extends RigidBody2D

@onready var spr_gift_anim : AnimatedSprite2D = $spr_gift_anim
# Called when the node enters the scene tree for the first time.
func _ready():
	var random0 : int = randi() % 6 
	spr_gift_anim.frame = random0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_gift_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_gift_body_entered(body):
	
	if body is Player:
		GLOBALS.emit_signal('gift_picked')
		queue_free()
