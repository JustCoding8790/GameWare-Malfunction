extends Node2D
@onready var timer: Label = $Timer

var time : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	timer.text = str(snapped(time, 0.1))

func timer_process(start_time: float):
	time = start_time
	
	while time > 0.0:
		await wait(0.1)
		time = time - 0.1
		if (time > 3.0 and start_time == 4.0) or (time > 6.0 and start_time == 8.0):
			timer.add_theme_color_override("font_color", Color("#52a96b"))
		elif (time > 2.0 and start_time == 4.0) or (time > 4.0 and start_time == 8.0):
			timer.add_theme_color_override("font_color", Color("#e1b100"))
		else:
			timer.add_theme_color_override("font_color", Color("#ef5b67"))
	return
	
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
