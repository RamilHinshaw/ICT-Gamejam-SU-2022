extends Area

export var sfx_finished:AudioStream
onready var render = $MeshInstance
# Called when the node enters the scene tree for the first time.
func _ready():
	render.visible = false

func _on_body_entered(body):
	
	Global.play_sfx(sfx_finished)
	yield(get_tree().create_timer(2), "timeout")
	Global.next_level()
