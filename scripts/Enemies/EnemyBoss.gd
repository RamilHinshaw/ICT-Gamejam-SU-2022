extends Enemy

var timer = 0
export var attackDelay:float = 1;

export var useSinVert:bool = false
export var useSinHori:bool = false
export var sinMagnitude = 5
export var sinSpeed = 2

export var moveDir:Vector2

#export var projectilePrefab2 = preload("res://prefabs/projectiles/EnemyProjectileTest.tscn")
#export var projectilePrefab2 = preload("res://prefabs/projectiles/EnemyProjectileTest.tscn")

var sinVal:float

func _ready():
#	print(global_transform.origin.z)
#	print(LevelSettings.player.global_transform.origin.z)
	timer = attackDelay

func AI_LOGIC(dt):	
	
	#AGGRO
	var playerPos = LevelSettings.player.global_transform.origin.z
	var distance = global_transform.origin.z - playerPos	
	
	if (distance < aggroRange and playerPos < global_transform.origin.z):
		timer -= dt
	
		if timer <= 0:
			attack()
			
#		movement(dt, moveDir.x, moveDir.y)
		x_input = moveDir.x
		y_input = moveDir.y
		
		
		if useSinHori:
			sinVal += dt * sinSpeed * moveDir.x
			x_input = sin(sinVal) * sinMagnitude
			
		if useSinVert:
			sinVal += dt * sinSpeed * moveDir.y
			y_input = sin(sinVal) * sinMagnitude

		
#		motion = Vector3(moveDir.x, moveDir.y, 0)


func attack():	
#	print("EYE MONSTER FIRED!")
	shoot(true)
	timer = attackDelay

func shoot(shoot_input):
	.shoot(shoot_input)
	
	if shoot_input == true:	
		var playerPos = LevelSettings.player.global_transform.origin
		var attackDir:Vector3 = playerPos - global_transform.origin
		lastProjectile.setMotion(attackDir)

func hurt(damage:int):
	health -= damage
	print("BOSS HURT")
	
	if (health <= 0):
		death()
		
	else:
		Global.play_backgroundsound(sfx_hurt)
		
func death():
	print("BOSS DEFEATED!")
	Global.play_backgroundsound(sfx_death)
	Global.next_level_delay(2)	
	queue_free()

