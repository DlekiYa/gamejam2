extends Node2D

class_name GameManager

@export var altar_spots: Array[Node2D]
var altars: Array[Altar]
@export var volcano_manager: VolcanoManager
@export var grid: Grid
@export var player: Player

const altar_scene: PackedScene = preload("res://altar/Altar.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.game_manager = self
	altars.resize(5)
	start_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Global.time_until_eruption -= delta
	player.debug_timer.text = str(int(Global.time_until_eruption))

func start_game():
	var first_altar: Altar = altar_scene.instantiate()
	var whatever = load("res://altar/OwlAltar.tres")
	var altar_res: AltarRes = whatever
	first_altar.set_altar_res(altar_res)
	altar_spots[0].add_child(first_altar)
	altars[0] = first_altar

func next_stage():
	pass

func sacrifice() -> bool:
	for altar in altars:
		if altar == null:
			continue
		if altar.altar_res.check_requirements(grid.items):
			continue
		return false
	next_stage()
	print("lets goo")
	return true
