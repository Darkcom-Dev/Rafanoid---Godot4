extends CanvasLayer

@onready var anim_player = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	layer = -1
	fade_in() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func fade_in():
	layer = 1
	anim_player.play("fade")
	await anim_player.animation_finished
	layer = -1
