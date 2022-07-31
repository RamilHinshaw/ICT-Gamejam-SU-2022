extends Area

export var damage:int = 1


func _on_body_entered(body):
#	if Global.is_world_paused or Global.is_player_paused:
#		return
	
	if body.name == "Player":
		body.hurt(damage)

