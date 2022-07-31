extends Enemy


func AI_LOGIC(): 	
	attack()


func attack():
	yield(get_tree().create_timer(2), "timeout")
	print("EYE MONSTER FIRED!")
	shoot(true)
