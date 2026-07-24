extends CharacterBody2D

var speed = 40
var player_chase =  false
var player = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_chase:
		position += (player.global_position - self.global_position)/speed



func _on_find_player_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		player_chase =  true


func _on_find_player_body_exited(body: Node2D) -> void:
	if body is Player:
		player = null
		player_chase =  false

func enemy():
	pass
