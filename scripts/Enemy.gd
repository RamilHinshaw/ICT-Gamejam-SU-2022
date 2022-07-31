extends Character

export var clampPlayer:bool = true

class_name Enemy

func AI_LOGIC(delta):
	pass

func _process(delta):
	AI_LOGIC(delta)
	
func hurt(damage:int):
	health -= damage
	
	if (health <= 0):
		death()

func death():
	queue_free()
