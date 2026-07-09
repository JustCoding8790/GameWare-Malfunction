extends Node2D
@onready var themed_timer: Node2D = $ThemedTimer
@onready var ruby: Area2D = $Ruby
@onready var spawn_point: Area2D = $SpawnPoint
@onready var spawn_point_2: Area2D = $SpawnPoint2

var rubies_collected = 0
var timer_end = false

func _ready() -> void:
	var spawn_num = randi_range(1, 2)
	if spawn_num == 1:
		ruby.global_position = spawn_point.global_position
	else:
		ruby.global_position = spawn_point_2.global_position
	ruby.ruby_collected.connect(ruby_collect)
	await themed_timer.timer_process(4.0)
	timer_end = true

func _process(_delta: float) -> void:
	if rubies_collected == 1:
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
