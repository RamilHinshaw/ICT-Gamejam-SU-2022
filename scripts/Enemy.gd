extends Character

#When it can see the player
export var aggroRange:float = 40 
export var points = 100

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
	Global.play_sfx(sfx_death)
	Global.scoreInLevel += points
	Global.update_score()
	queue_free()
