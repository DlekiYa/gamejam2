extends Sprite2D


@export var grid: Array[Node2D]
@export var highlight_sprite: Sprite2D
var items: Array[InvItem]
var selected: int
var player_inside: Player
const display_item_scene: PackedScene = preload("res://grid/display_item_on_grid.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var area_2d: Area2D = $GridArea
	area_2d.body_entered.connect(_body_entered)
	area_2d.body_exited.connect(_body_exited)
	for i: int in 9:
		items.append(null)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player_inside != null:
		recalc_closest(player_inside)

func find_closest_index(pos: Vector2) -> int:
	var min_dist: float = 100000.0
	var min_index: int= -1
	var curr_index: int = 0
	for node: Node2D in grid:
		if node.global_position.distance_to(pos) < min_dist:
			min_dist = node.global_position.distance_to(pos)
			min_index = curr_index
		curr_index += 1
	return min_index

func recalc_closest(player: Player) -> void:
	selected = find_closest_index(player.global_position)
	highlight_sprite.position = grid[selected].position
	highlight_sprite.show()

func _body_entered(body: Node2D) -> void:
	if body is Player:
		player_inside = body
		body.set_over_grid(true)

func _on_area_entered(area: Area2D):
	if area is ItemOnGround:
		if put_item(area):
			area.queue_free()

func _body_exited(body: Node2D) -> void:
	if body is Player:
		highlight_sprite.hide()
		player_inside = null
		selected = -1
		body.set_over_grid(false)

func put_item(item_on_ground: ItemOnGround) -> bool:
	var closest_index = find_closest_index(item_on_ground.global_position)
	if items[closest_index] != null:
		return false
	items[closest_index] = item_on_ground.item
	var display_item: Sprite2D = display_item_scene.instantiate()
	display_item.texture = item_on_ground.item.texture
	grid[closest_index].add_child(display_item)
	return true

func erase_item(slot: int) -> InvItem:
	for child in grid[slot].get_children():
		child.queue_free()
	var item = items[slot]
	items[slot] = null
	return item

func take() -> InvItem:
	if player_inside == null or selected == -1 or items[selected] == null:
		return null
	return erase_item(selected)
