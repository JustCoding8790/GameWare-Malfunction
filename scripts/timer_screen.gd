extends Node2D
@onready var garlic_container: HBoxContainer = $CanvasLayer/GarlicContainer
@onready var garlic: TextureRect = $CanvasLayer/GarlicContainer/Garlic
@onready var garlic_2: TextureRect = $CanvasLayer/GarlicContainer/Garlic2
@onready var garlic_3: TextureRect = $CanvasLayer/GarlicContainer/Garlic3
@onready var garlic_4: TextureRect = $CanvasLayer/GarlicContainer/Garlic4
@onready var level: Label = $CanvasLayer/Level
@onready var timer: Label = $CanvasLayer/Timer

var time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await timer_process(5.0)
	if Global.minigames_done < 3:
		Global.minigames_done += 1
		get_tree().change_scene_to_file("res://scenes/minigame_" + str(Global.minigames_done) + ".tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/title_screen.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	match Global.lives:
		3:
			garlic_4.hide()
		2:
			garlic_4.hide()
			garlic_3.hide()
		1:
			garlic_4.hide()
			garlic_3.hide()
			garlic_2.hide()
		0:
			garlic_container.hide()
	timer.text = str(time)
	level.text = str(Global.minigames_done)

func timer_process(start_time: float) -> void:
	time = start_time
	
	while time > 0.0:
		await wait(0.1)
		time -= 0.1
	
	return

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
