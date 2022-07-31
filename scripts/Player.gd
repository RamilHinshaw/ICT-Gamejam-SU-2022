extends Character

class_name Player

export var canLean:bool = true

export var leanHorizontalMaxAngle:float = 35
export var leanVerticalMaxAngle:float = 15

# ONREADY
onready var spaceship:Spatial = $spaceship




# Called when the node enters the scene tree for the first time.
func _ready():
#	LevelSettings.player = self
	playerControls()

func _process(dt):
	playerControls()
	
	._process(dt)
	
func playerControls():
		# PLAYER CONTROLS
	x_input = (Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right"))
	y_input = (Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down"))
	shoot_input = 	Input.is_action_just_pressed("ui_accept")


func _physics_process(dt):
	
	motion.z = 0
	lean(dt, x_input, y_input)	
	
	# Call Base Physics
	._physics_process(dt)
	
#	print(LevelSettings.player.transform.origin)
	
func lean(dt, x_input, y_input):
	spaceship.rotation.z = lerp(spaceship.rotation.z, atan2(-x_input, 0)/2.5, 2.5 * dt)

	



	
func hurt(damage:int):
	health -= damage
	print(health)
	
	if (health <= 0):
		death()
	
	
func death():
	print("DEATH!")
	Global.reset_level(true)

