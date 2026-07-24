extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.current_action = body.ActionState.SACRIFICE
		body.tip_label.add_state(body.tip_label.State.ACTIVATE)


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.current_action = body.ActionState.NOTHING
		body.tip_label.remove_state(body.tip_label.State.ACTIVATE)
