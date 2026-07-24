extends CharacterBody2D

class_name Player

var speed = 500
var Currentslot = 0
var health = 3

@onready var Grid = $"../Grid"

enum walking_enum {WALKING_STRAIGHT, WALKING_LEFT, WALKING_RIGHT, IDLE}
var currently_walking: walking_enum = walking_enum.IDLE
@export var animated_sprite: AnimatedSprite2D
var hovering_over_item: ItemOnGround
var over_grid: bool = false
enum ActionState {SACRIFICE, FISHING, NOTHING}
var current_action: ActionState = ActionState.NOTHING
var game_manager: GameManager

@export var inv: Inv
@export var debug_timer: Label
@export var tip_label: LabelTip

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
	if Input.is_action_just_pressed("action_key"):
		match current_action:
			ActionState.SACRIFICE:
				game_manager.sacrifice()
			ActionState.NOTHING:
				pass
	if Input.is_key_pressed(KEY_1):
		Currentslot = 0
	elif Input.is_key_pressed(KEY_2):
		Currentslot = 1
	elif Input.is_key_pressed(KEY_3):
		Currentslot = 2
	elif Input.is_key_pressed(KEY_4):
		Currentslot = 3
	elif Input.is_key_pressed(KEY_5):
		Currentslot = 4
	elif Input.is_key_pressed(KEY_6):
		Currentslot = 5
	elif Input.is_key_pressed(KEY_7):
		Currentslot = 6
	elif Input.is_key_pressed(KEY_8):
		Currentslot = 7
		
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up","ui_down")
	handle_animation(direction)
	velocity = direction * speed 
	move_and_slide()

func handle_animation(direction: Vector2) -> void:
	if direction == Vector2.ZERO and currently_walking != walking_enum.IDLE:
		currently_walking = walking_enum.IDLE
		animated_sprite.play("up_down")
		animated_sprite.flip_h = false
		animated_sprite.stop()
		animated_sprite.frame = 0
	elif direction != Vector2.ZERO:
		if abs(direction.x) < 0.1 and currently_walking != walking_enum.WALKING_STRAIGHT:
			currently_walking = walking_enum.WALKING_STRAIGHT
			animated_sprite.play("up_down")
			animated_sprite.flip_h = false
		elif direction.x >= 0.1 and currently_walking != walking_enum.WALKING_RIGHT:
			currently_walking = walking_enum.WALKING_RIGHT
			animated_sprite.play("left_right")
			animated_sprite.flip_h = false
		elif direction.x <= -0.1 and currently_walking != walking_enum.WALKING_LEFT:
			currently_walking = walking_enum.WALKING_LEFT
			animated_sprite.play("left_right")
			animated_sprite.flip_h = true

func offer_pick_up(item: ItemOnGround) -> void:
	hovering_over_item = item
	tip_label.add_state(tip_label.State.PICK_UP)

func forget_pick_up(item: ItemOnGround) -> void:
	tip_label.remove_state(tip_label.State.PICK_UP)
	if hovering_over_item == item:
		hovering_over_item = null

func collect(item: ItemOnGround) -> void:
	if inv.insert(item.item, Currentslot, self):
		item.queue_free()

func drop() -> void:
	inv.drop(Currentslot, self)

func set_over_grid(state: bool) -> void:
	over_grid = state

func highlight() -> void:
	for i in 8:
		$inv_ui.slots[i].modulate = Color(1.0, 1.0, 1.0, 1.0) 
	$inv_ui.slots[Currentslot].modulate = Color(1.353, 1.353, 1.353, 1.0) 

func diplay_altar_tip(altar: AltarRes) -> void:
	$AltarRequirements.set_altar(altar)
	$AltarRequirements.show()

func hide_altar_tip() -> void:
	$AltarRequirements.hide()


func _on_deathbyenemy_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		get_tree().reload_current_scene()
		for i in 8:
			inv.clear(i, self)
		
