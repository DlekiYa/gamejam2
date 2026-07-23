extends Sprite2D

var scaling_factor = 0.02

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if scale.x > 1.2 or scale.x < 0.9:
		scaling_factor *= -1.0
	scale.x += scaling_factor
	scale.y += scaling_factor
