extends Enemy

var timer = 0
export var timerInit = 1;

export var moveDir:Vector2

func _ready():
	print(global_transform.origin.z)
	print(LevelSettings.player.global_transform.origin.z)
	timer = timerInit

func AI_LOGIC(dt):	
	
	#AGGRO
	var playerPos = LevelSettings.player.global_transform.origin.z
	var distance = global_transform.origin.z - playerPos	
	
	if (distance < aggroRange and playerPos < global_transform.origin.z):
		timer -= dt
	
		if timer <= 0:
			attack()
			
#		movement(dt, moveDir.x, moveDir.y)
		
		motion = Vector3(moveDir.x, moveDir.y, 0)


func attack():	
#	print("EYE MONSTER FIRED!")
	shoot(true)
	timer = timerInit

func shoot(shoot_input):
	.shoot(shoot_input)
	
	if shoot_input == true:	
		var playerPos = LevelSettings.player.global_transform.origin
		var attackDir:Vector3 = playerPos - global_transform.origin
		lastProjectile.setMotion(attackDir)
	
