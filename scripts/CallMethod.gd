extends Node

export var nodePath:NodePath
export var methodName:String

export var call_function:bool

#export(Array, Resource) var events

#export(String, "White", "Yellow", "Orange") var my_color

#export var derp:NodePath

func testPrint():
	print("Hello World From Test!!")

func _ready():
	if !call_function: return
	
	var node:Node = get_node(nodePath)
	if methodName != null && node.has_method(methodName):
		node.call(methodName)
