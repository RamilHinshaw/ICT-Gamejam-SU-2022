extends Camera

class_name CameraController

export var targetPath:NodePath
var target:Spatial
export var clampHorizontal:Vector2 = Vector2(-5.7,5.7)
export var clampVertical:Vector2 = Vector2(-0.466,6.1)


# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_node(targetPath)
#	target = LevelSettings.player


func _physics_process(delta):
	followTargetClamp()

func followTargetClamp():
	
	if target == null: 
		print("NULL")
		return
	
	var xPos = clamp(target.transform.origin.x, clampHorizontal.x, clampHorizontal.y)
	var yPos = clamp(target.transform.origin.y, clampVertical.x, clampVertical.y)
	
	
	transform.origin = Vector3(xPos, yPos, transform.origin.z)
