extends KinematicBody

class_name Projectile

export var speed:float = 3
export var damage:float = 1
export var lifetime:float = 3
export var isFriendly:bool = false

onready var shape:CollisionShape = $Area/CollisionShape

var motion = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	motion.z = speed
	yield(get_tree().create_timer(lifetime), "timeout")
	queue_free()
	
func setMotion(dir:Vector3):
	motion = Vector3.ZERO
	motion = dir * speed

func _physics_process(dt):
	move_and_slide(motion, Vector3.UP)


func disable_hitbox(): # YOU HAVE TO DISABLE IT THIS WAY BECAUSE GODOT HATES ME
	shape.set_deferred("disabled", true)


func _on_body_entered(body):
	
	#Enemy Projectile
	if isFriendly == false && body.name == "Player":
		body.hurt(damage)
	
	#Player Projectile	
	elif isFriendly && body.name != "Player":
		body.hurt(damage)
	
	destroyProjectile()
	
func destroyProjectile():
	queue_free()
