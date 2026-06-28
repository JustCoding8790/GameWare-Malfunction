extends Node2D
@onready var themed_timer: Node2D = $ThemedTimer

var rubies_collected = 0
var timer_end = false

func _ready() -> void:
	await themed_timer.timer_process(8.0)
	timer_end = true

func _process(_delta: float) -> void:
	if rubies_collected == 2:
		if Global.minigames_done > 3:
			get_tree().change_scene_to_file("res://scenes/done_screen.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/level_scene.tscn")
	
	if timer_end:
		Global.minigames_done -= 1
		Global.lives -= 1
		get_tree().change_scene_to_file("res://scenes/level_scene.tscn")

func ruby_collect() -> void:
	rubies_collected += 1
	return
