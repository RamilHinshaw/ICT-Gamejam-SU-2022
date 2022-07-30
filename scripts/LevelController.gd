extends KinematicBody

class_name LevelController

export var speed:float = 8

export var clampHorizontal:Vector2 = Vector2(-5,5)
export var clampVertical:Vector2 = Vector2(-5,5)

var _motion = Vector3.ZERO


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	LevelSettings.clampHorizontal = clampHorizontal
	LevelSettings.clampVertical = clampVertical
	_motion.z = speed
	
func _physics_process(dt):
	move_and_slide(_motion * speed, Vector3.UP)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
