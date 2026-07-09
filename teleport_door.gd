extends Area2D

# Drag the destination Area2D node here in the Inspector
func _on_body_entered(body: Node) -> void:
	var destination_name = self.name + "2"
	var destination_area = get_parent().get_node_or_null(destination_name)
	if body.name == "Player" and destination_area:
		body.global_position = destination_area.global_position
