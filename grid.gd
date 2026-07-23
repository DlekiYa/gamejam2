extends Sprite2D


@export var grid: Array[Node2D]
@export var highlight_sprite: Sprite2D
var selected: int
var player_inside: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var area_2d: Area2D = $Area2D
	area_2d.body_entered.connect(_body_entered)
	area_2d.body_exited.connect(_body_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player_inside != null:
		recalc_closest(player_inside)


func recalc_closest(player: Player) -> void:
	var min_dist: float = 100000.0
	var min_index: int= -1
	var curr_index: int = 0
	for node: Node2D in grid:
		if node.global_position.distance_to(player.global_position) < min_dist:
			min_dist = node.global_position.distance_to(player.global_position)
			min_index = curr_index
		curr_index += 1
	selected = min_index
	highlight_sprite.position = grid[selected].position
	highlight_sprite.show()

func _body_entered(body: Node2D) -> void:
	if body is Player:
		player_inside = body

func _body_exited(body: Node2D) -> void:
	if body is Player:
		highlight_sprite.hide()
		player_inside = null
