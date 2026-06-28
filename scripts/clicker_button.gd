extends TextureButton
@onready var button_1: TextureButton = $"."
@onready var parent: Node2D = $"../.."

func _on_pressed() -> void:
	button_1.disabled = true
	parent.buttons_pressed += 1
