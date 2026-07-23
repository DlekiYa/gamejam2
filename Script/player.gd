extends CharacterBody2D

class_name Player

var speed = 500
var Currentslot = 0

@onready var Grid = $"../Grid"

var currently_walking: bool = false
@export var animated_sprite: AnimatedSprite2D
var hovering_over_item: ItemOnGround
var over_grid: bool = false

@export var inv: Inv

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	highlight()


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("scroll_up"):
		Currentslot = (Currentslot - 1 + 8) % 8
		highlight()
	if Input.is_action_just_pressed("scroll_down"):
		Currentslot = (Currentslot + 1) % 8
		highlight()
	if Input.is_action_just_pressed("pick_up_key"):
		if hovering_over_item != null:
			collect(hovering_over_item)
		elif over_grid:
			inv.insert(Grid.take(), Currentslot, self)
	if Input.is_action_just_pressed("drop_key"):
		inv.drop(Currentslot, self)
	
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up","ui_down")
	if direction == Vector2.ZERO and currently_walking:
		currently_walking = false
		animated_sprite.stop()
		animated_sprite.set_frame_and_progress(0, 0.0)
	elif direction != Vector2.ZERO and not currently_walking:
		currently_walking = true
		animated_sprite.play()
	
	velocity = direction * speed 
	move_and_slide()
	
func offer_pick_up(item: ItemOnGround) -> void:
	hovering_over_item = item
	$label_pick_up.show()

func forget_pick_up(item: ItemOnGround) -> void:
	if hovering_over_item == item:
		hovering_over_item = null
		$label_pick_up.hide()

func collect(item: ItemOnGround):
	if inv.insert(item.item, Currentslot, self):
		item.queue_free()

func drop():
	inv.drop(Currentslot, self)

func set_over_grid(state: bool) -> void:
	over_grid = state

func highlight():
	for i in 8:
		$inv_ui.slots[i].modulate = Color(1.0, 1.0, 1.0, 1.0) 
	$inv_ui.slots[Currentslot].modulate = Color(1.353, 1.353, 1.353, 1.0) 
