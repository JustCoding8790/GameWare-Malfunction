extends Node2D
@onready var themed_timer: Node2D = $ThemedTimer
@onready var button_container: Node2D = $ButtonContainer

var buttons_pressed := 0
var timer_end = false

func _ready() -> void:
	await themed_timer.timer_process(8.0)
	timer_end = true 

func _process(delta: float) -> void:
	if buttons_pressed == 7:
		if Global.minigames_done > 3:
			get_tree().change_scene_to_file("res://scenes/done_screen.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/level_scene.tscn")
	
	if timer_end:
		Global.lives -= 1
		Global.minigames_done -=1
		get_tree().change_scene_to_file("res://scenes/level_scene.tscn")
