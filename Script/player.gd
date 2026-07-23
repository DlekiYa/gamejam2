extends CharacterBody2D

class_name Player

var speed = 500
var Currentslot = 0

@onready var Grid = $"../Grid"

@export var inv: Inv
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("scroll up"):
		if Currentslot != 7:
			Currentslot += 1
		else:
			Currentslot = 0
	if Input.is_action_just_pressed("scroll down"):
		if Currentslot != 0:
			Currentslot -= 1
		else:
			Currentslot = 7
	highlight()
	var direction = Input.get_vector("left", "right", "up","down")
	
	velocity = direction * speed 
	move_and_slide()

func collect(item):
	inv.insert(item)
	

func player():
	pass

func highlight():
	for i in 8:
		$inv_ui.slots[i].modulate = Color(1.0, 1.0, 1.0, 1.0) 
	$inv_ui.slots[Currentslot].modulate = Color(1.353, 1.353, 1.353, 1.0) 
	if !inv.slots[Currentslot].item == null:
		Grid.highlight_sprite.texture = inv.slots[Currentslot].item.texture
	else:
		Grid.highlight_sprite.texture = null
