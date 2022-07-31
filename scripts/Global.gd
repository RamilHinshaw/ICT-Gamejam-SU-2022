extends Node

#export var sfx_level_complete:AudioStream

export var current_level:int = 0
#var is_paused: bool = false
#
#
#var can_pause:bool = true

export(Array, PackedScene) var levels
export var last_level:PackedScene
export var title_level:PackedScene

#Used to change fade name
var _death_subtext = ""




#----------------------------------------------------------
# FADE PROPERTIES
enum FADE_TYPE {fadeOut, fadeIn, none}
onready var _anim_fade:AnimationPlayer = $AnimFade
onready var _control:Control = $CanvasLayer/Control
onready var _colorRect:ColorRect = $CanvasLayer/Control/ColorRect

#--------------- AUDIO PROPERTIES--------------------
onready var _audio_bgm:AudioStreamPlayer = $BGM
onready var _audio_bgs:AudioStreamPlayer = $BGS

onready var _audio_sfx01:AudioStreamPlayer = $Sfx01
onready var _audio_sfx02:AudioStreamPlayer = $Sfx02
onready var _audio_sfx03:AudioStreamPlayer = $Sfx03
onready var _audio_sfx04:AudioStreamPlayer = $Sfx04
onready var _audio_sfx05:AudioStreamPlayer = $Sfx05
onready var _audio_sfx06:AudioStreamPlayer = $Sfx06
var _sfx_counter:int = 0 #used to play the next buffer
# ---------------------------------------------------

onready var death_animation:AnimationPlayer = $DeathAnimation/AnimationPlayer

#PLAYER INFO : HARDCODED IN!
#var player:KinematicBody2D

func _ready():
	_control.visible = false
	print(get_tree().get_current_scene().get_name())


func _process(delta):
	
	if (get_tree().get_current_scene().get_name() == "Title RE"):
		return
	
	if Input.is_action_just_released("ui_reset"):
		reset_level(false)
		
	if Input.is_action_just_released("ui_esc"):
		#_audio_bgm.stop()
		get_tree().change_scene("res://scenes/Title RE.tscn")
		current_level = 0
		
	if Input.is_action_just_released("ui_next"):
		next_level()
		
	#if Input.is_action_just_pressed("start"):
	#get_tree().change_scene("res://Scene/UI/TitleScreen.tscn")		

func camera_shake():
	pass
	

func next_level():
	_death_subtext = ""
	
	current_level += 1
	
	var scene
	
	if current_level >= levels.size():
		scene = last_level
			
	else:
		scene = levels[current_level]	
		
	#IF END SCENE
	if (get_tree().get_current_scene().get_name() == "End"):
		scene = title_level
	
	change_scenePacked(scene)

func reset_level(has_died):
	if has_died:
		_death_subtext = "Death"
	else:
		_death_subtext = ""
	
	var scene = levels[current_level]
	change_scenePacked(scene)
	
	
func change_scene(scene_path:String, transition:int = 0):
	get_tree().change_scene(scene_path)
	
func reset_values():
	return
#	is_selected_vanishing_block_red = true
	
func change_scenePacked(scene:PackedScene, transition:int = 0):	
	
	_control.visible = true
	_anim_fade.play("FadeIn" + _death_subtext)
	
	yield(_anim_fade, "animation_finished")	
	yield(get_tree().create_timer(0.25), "timeout")
	
	get_tree().change_scene_to(scene)	
	_anim_fade.play("FadeOut" + _death_subtext)
	
	# GAIN BACK CONTROl
	reset_values();	
#	is_world_paused = false
	_anim_fade.playback_speed = 1

	
	yield(_anim_fade, "animation_finished")	
	_control.visible = false
	
# Used to check if both rods selected
func level_win(modifier:int):
#		play_sfx(sfx_level_complete)
		
		yield(get_tree().create_timer(1), "timeout")
		_anim_fade.playback_speed = 0.4
		next_level()		

	
func play_music(music : AudioStream, fade_dur: float = 0):
	
	if _audio_bgm.stream == music:
		return
		
	_audio_bgm.stream = music
	_audio_bgm.play()
	pass
	
func fadeout_music(fade_dur: float):
	pass

func play_sfx(sfx : AudioStream):
	
	var player:AudioStreamPlayer 
	
	match _sfx_counter:
		0: player = _audio_sfx01
		1: player = _audio_sfx02
		2: player = _audio_sfx03
		3: player = _audio_sfx04
		4: player = _audio_sfx05
		5: player = _audio_sfx06
		
	_sfx_counter += 1
	if _sfx_counter > 5:
		_sfx_counter = 0
		
	player.stream = sfx
	player.play()

	pass
	
#func pause(val:bool):
#	can_pause = !val
#	get_tree().paused = val	
	
#func pause_actors(val: bool) -> void:
#	get_tree().call_group("Actors", "Pause")
#	pass
	

#func death(pos: Vector2):
#	death_animation.get_parent().global_position = pos
#	death_animation.play("death")
#
