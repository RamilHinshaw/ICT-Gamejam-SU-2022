extends KinematicBody

class_name Character

export var health = 1
export var speed = 3
export var airFriction:float = 0.25
export var clampToScreen:bool = false
export var motion:Vector3 = Vector3.ZERO

export var fireOffset:Vector3 = Vector3.ZERO

#INPUTS
var x_input = 0
var y_input  = 0
var shoot_input:bool  = false

# LOAD
export var projectilePrefab = preload("res://prefabs/projectiles/PlayerProjectileTest.tscn")
var lastProjectile

# Called when the node enters the scene tree for the first time.
func _ready():
	x_input = 0
	y_input = 0
	shoot_input = false

func _physics_process(dt):
	
	movement(dt, x_input, y_input)
#	lean(dt, x_input, y_input)
	
	shoot(shoot_input)

		
	move_and_slide(motion, Vector3.UP)

func movement(dt, x_input, y_input):
	
	var targetDir:Vector3 = Vector3(x_input, y_input, 0)
	targetDir.normalized()
	
	var motionX:float = 0
	var motionY:float = 0
	
	targetDir.normalized()	
	
	#GOING LEFT CLAMP | Going positive on x
	if (transform.origin.x < LevelSettings.clampHorizontal.y && targetDir.x > 0 && clampToScreen):
		motionX = targetDir.x * speed
		
	#GOING RIGHT CLAMP
	if (transform.origin.x > LevelSettings.clampHorizontal.x && targetDir.x < 0 && clampToScreen ):
		motionX = targetDir.x * speed
		
	#GOING UP CLAMP | Going positive on y
	if (transform.origin.y < LevelSettings.clampVertical.y && targetDir.y > 0 && clampToScreen ):
		motionY = targetDir.y * speed
		
	#GOING DOWN CLAMP
	if (transform.origin.y > LevelSettings.clampVertical.x && targetDir.y < 0 && clampToScreen ):
		motionY = targetDir.y * speed

	if clampToScreen == false:
		motionX = targetDir.x * speed
		motionY = targetDir.y * speed
#		print(transform.origin)

	motion.x = lerp(motionX, 0, airFriction)
	motion.y = lerp(motionY, 0, airFriction)
	
#	return motion
	
#func _process(dt):

func shoot(shoot_input):
	if shoot_input:
		lastProjectile = projectilePrefab.instance()
		get_tree().get_root().add_child(lastProjectile)
		lastProjectile.global_transform.origin = global_transform.origin
		lastProjectile.global_transform.origin += fireOffset
	
func hurt(damage:int):
	pass

func death():
	pass
