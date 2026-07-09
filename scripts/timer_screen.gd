extends Node2D
@onready var garlic_container: HBoxContainer = $CanvasLayer/GarlicContainer
@onready var garlic: TextureRect = $CanvasLayer/GarlicContainer/Garlic
@onready var garlic_2: TextureRect = $CanvasLayer/GarlicContainer/Garlic2
@onready var garlic_3: TextureRect = $CanvasLayer/GarlicContainer/Garlic3
@onready var garlic_4: TextureRect = $CanvasLayer/GarlicContainer/Garlic4
@onready var level: Label = $CanvasLayer/Level
@onready var timer: Label = $CanvasLayer/Timer
@onready var canvas_lose: CanvasLayer = $CanvasLose
@onready var canvas_win: CanvasLayer = $CanvasWin
@onready var lose_animation: AnimationPlayer = $CanvasLose/LoseAnimation
@onready var win_animation: AnimationPlayer = $CanvasWin/WinAnimation
@onready var game_instruction: Label = $CanvasLayer/GameInstruction
@onready var instruction_animation: AnimationPlayer = $CanvasLayer/GameInstruction/InstructionAnimation

var time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_instruction.visible = false
	match Global.minigames_done:
		0:
			game_instruction.text = "Collect both rubies!"
		1:
			game_instruction.text = "Click all the gems!"
		2:
			game_instruction.text = "Find the ruby!"
	await timer_process(2.0)
	if Global.lives == 0:
		game_over()
	elif Global.minigames_done < 3:
		get_tree().change_scene_to_file("res://scenes/minigame_" + str(Global.minigames_done) + ".tscn")
		Global.minigames_done += 1
	else:
		canvas_win.visible = true
		win_animation.play("fly_in")
		await wait(4.0)
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
		if is_equal_approx(time, 1) and Global.minigames_done < 3:
			game_instruction.visible = true
			instruction_animation.play("zoom_in")
	return

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func game_over() -> void:
	canvas_lose.visible = true
	lose_animation.play("fly_in")
	await wait(4.0)
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
	
