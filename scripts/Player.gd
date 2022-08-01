extends Character

class_name PlayerChar

export var canLean:bool = true

export var leanHorizontalMaxAngle:float = 35
export var leanVerticalMaxAngle:float = 15

# ONREADY
onready var spaceship:Spatial = $spaceship




# Called when the node enters the scene tree for the first time.
func _ready():
#	LevelSettings.player = self
	playerControls()
	Global.update_health(health)

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
#	print(health)
	Global.update_health(health)
	
	if (health <= 0):
		death()
		
	else:
		Global.play_sfx(sfx_hurt)
#		Global.fadeRed()
	
	
func death():
	print("DEATH!")
	Global.play_sfx(sfx_death)
	Global.reset_level(true)

