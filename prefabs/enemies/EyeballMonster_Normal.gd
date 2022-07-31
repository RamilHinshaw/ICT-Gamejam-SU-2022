extends Enemy

var timer = 0
export var timerInit = 1;

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
	
	
	


func attack():	
#	print("EYE MONSTER FIRED!")
	shoot(true)
	timer = timerInit
