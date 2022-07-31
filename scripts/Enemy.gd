extends Character


export var clampPlayer:bool = true

#var projectilePrefab = preload("res://prefabs/PlayerProjectiles/ProjectileTest.tscn")

func _physics_process(delta):
	pass

func shoot(shoot_input):
	pass
	
func movement(dt, x_input, y_input):
	pass

	
func hurt(damage:int):
	health -= damage
	
	if (health <= 0):
		death()

func death():
	queue_free()
