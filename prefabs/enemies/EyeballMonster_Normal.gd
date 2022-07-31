extends Enemy

var timer = 0
export var timerInit = 1;

func _ready():
	timer = timerInit

func AI_LOGIC(dt): 	
	
	timer -= dt
	
	if timer <= 0:
		attack()
	


func attack():	
	print("EYE MONSTER FIRED!")
	shoot(true)
	timer = timerInit
