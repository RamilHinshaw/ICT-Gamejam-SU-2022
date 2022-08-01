extends KinematicBody

class_name LevelController

export var speed:float = 8

export var clampHorizontal:Vector2 = Vector2(-5,5)
export var clampVertical:Vector2 = Vector2(-5,5)
#onready var cameraController:CameraController = $Camera

var _motion = Vector3.ZERO


onready var player:PlayerChar = $Player



# Called when the node enters the scene tree for the first time.
func _ready():
	LevelSettings.clampHorizontal = clampHorizontal
	LevelSettings.clampVertical = clampVertical
	_motion.z = speed
#	LevelSettings.cameraController = cameraController
	LevelSettings.player = player
	
func _physics_process(dt):
	move_and_slide(_motion * speed, Vector3.UP)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
