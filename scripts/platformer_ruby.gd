extends Node2D
@onready var collect_area: Area2D = $Area2D

signal ruby_collected

func _ready() -> void:
	collect_area.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if self.visible:
			emit_signal("ruby_collected")
			self.hide()
