# Root node for entire game
# Used to load menu, levels, everything

extends Node2D

var scenes = [
	preload("res://Main/Main.tscn"),
	preload("res://Main/Cutscene1.tscn"),
	preload("res://Main/Space-L1.tscn"),
	preload("res://Main/Ground-L1.tscn"),
	preload("res://Main/Win.tscn"),
	preload("res://Main/Death.tscn"),
	]
var currentScene = 0

onready var screen = $Screen
onready var sceneTransition = $Transition/AnimationPlayer

func _ready():
	Resolution()
	# Load main menu without any fading transition at start
	var scene = scenes[currentScene].instance()
	screen.add_child(scene)
	
#----------------------------------------Screen Resolution---------------------#

func Fullscreen():
	OS.window_fullscreen = !OS.window_fullscreen

func Resolution():
	if(OS.window_fullscreen):
		return
	if(get_viewport().size!=Vector2(1280,720)):
		OS.set_window_size(Vector2(1280,720))
	else:
		OS.set_window_size(Vector2(640,360))

#-----------------------------------------Scene loading------------------------#

# Exits the game
func Exit():
	get_tree().quit()

# Clears the screen
func ClearScreen():
	for child in screen.get_children():
		screen.remove_child(child)
		child.queue_free()

# Clears the screen and loads the current scene
func LoadLevel():
	sceneTransition.play("fade_out")
	yield(sceneTransition, "animation_finished")
	ClearScreen()
	var scene = scenes[currentScene].instance()
	screen.add_child(scene)
	sceneTransition.play("fade_in")
	yield(sceneTransition, "animation_finished")

# Sets the current scene, clears the screen and loads the current scene
func LoadLevelNo(sceneNo : int):
	currentScene = sceneNo
	LoadLevel()
