extends KinematicBody

export var speed:float = 3
export var damage:float = 1
export var lifetime:float = 3
export var isFriendly:bool = false

onready var shape:CollisionShape = $Area/CollisionShape

var _motion = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	_motion.z = speed
	yield(get_tree().create_timer(lifetime), "timeout")
	queue_free()

func _physics_process(dt):
	move_and_slide(_motion, Vector3.UP)


func disable_hitbox(): # YOU HAVE TO DISABLE IT THIS WAY BECAUSE GODOT HATES ME
	shape.set_deferred("disabled", true)


func _on_body_entered(body):
	
	#Enemy Projectile
	if isFriendly == false && body.name == "Player":
		body.hurt(damage)
	
	#Player Projectile	
	elif isFriendly && body.name != "Player":
		body.hurt(damage)
