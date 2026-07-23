extends Area2D
class_name ItemOnGround

@export var item: InvItem
var player: Player = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ItemSprite.texture = item.texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		return
	player = body
	player.offer_pick_up(self)

func _on_body_exited(body: Node2D) -> void:
	if body is not Player:
		return
	player.forget_pick_up(self)
