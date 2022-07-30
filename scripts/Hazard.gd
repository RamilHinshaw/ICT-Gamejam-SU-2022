extends Area

func _on_Hazard_body_entered(body):
#	if Global.is_world_paused or Global.is_player_paused:
#		return
	
	if body.name == "Player":
		pass
#		body.kill_player()
#		Global.reset_level(true)
