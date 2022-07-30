extends Character

export var acceleration:float = 512
export var speed = 3
export var airFriction:float = 0.25
export var motion:Vector3 = Vector3.ZERO
export var clampPlayer:bool = true

export var health = 5

export var leanHorizontalMaxAngle:float = 35
export var leanVerticalMaxAngle:float = 15

# ONREADY
onready var spaceship:Spatial = $spaceship

# LOAD
var projectilePrefab = preload("res://prefabs/projectiles/PlayerProjectileTest.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(dt):
	
	# PLAYER CONTROLS
	var x_input = (Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right"))
	var y_input = (Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down"))
	var shoot_input = 	Input.is_action_just_pressed("ui_accept")
	
	motion = movement(dt, x_input, y_input)
	shoot(shoot_input)
	shoot(shoot_input)

	motion.z = 0	
	move_and_slide(motion, Vector3.UP)
	
	
func lean(x_input, y_input):
	spaceship.lo
	pass
	
func movement(dt, x_input, y_input):

	var targetDir:Vector3 = Vector3(x_input, y_input, 0)
	targetDir.normalized()
	
	var motionX:float = 0
	var motionY:float = 0
	
	targetDir.normalized()	
	
	#GOING LEFT CLAMP | Going positive on x
	if (transform.origin.x < LevelSettings.clampHorizontal.y && targetDir.x > 0 && clampPlayer):
		motionX = targetDir.x * speed
		
	#GOING RIGHT CLAMP
	if (transform.origin.x > LevelSettings.clampHorizontal.x && targetDir.x < 0 && clampPlayer ):
		motionX = targetDir.x * speed
		
	#GOING UP CLAMP | Going positive on y
	if (transform.origin.y < LevelSettings.clampVertical.y && targetDir.y > 0 && clampPlayer ):
		motionY = targetDir.y * speed
		
	#GOING DOWN CLAMP
	if (transform.origin.y > LevelSettings.clampVertical.x && targetDir.y < 0 && clampPlayer ):
		motionY = targetDir.y * speed

	if !clampPlayer:
		motionX = targetDir.x * speed
		motionY = targetDir.y * speed
		print(transform.origin)

	motion.x = lerp(motionX, 0, airFriction)
	motion.y = lerp(motionY, 0, airFriction)
	
	return motion

func shoot(shoot_input):
	if shoot_input:
		var projectile = projectilePrefab.instance()
		get_tree().get_root().add_child(projectile)
		projectile.global_transform.origin = global_transform.origin
		projectile.global_transform.origin.z += 1
		# add_child(projectile)
	
func hurt(damage:float):
	health -= damage
	print(health)
