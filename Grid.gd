extends Sprite2D


@export
var grid: Array[Node2D]
var selected
@export
var highlight_sprite: Sprite2D
var player_inside: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_inside != null:
		recalc_closest(player_inside)


func recalc_closest(player: Node2D):
	var min_dist = 100000.0
	var min_index = -1
	var curr_index = 0
	for node in grid:
		if node.global_position.distance_to(player.global_position) < min_dist:
			min_dist = node.global_position.distance_to(player.global_position)
			min_index = curr_index
		curr_index += 1
	selected = min_index
	highlight_sprite.position = grid[selected].position
	highlight_sprite.show()

func player_entered_area(player: Node2D):
	player_inside = player

func player_left_area(player: Node2D):
	highlight_sprite.hide()
	player_inside = null
