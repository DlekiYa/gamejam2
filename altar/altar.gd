extends Node2D
class_name Altar

@export var altar_res: AltarRes
var curr_modulation_color: Color = Color(1.0, 1.0, 1.0)
var sprite: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if altar_res != null:
		sprite.texture = altar_res.texture

func set_altar_res(altar_res_: AltarRes) -> void:
	sprite = $AltarSprite
	altar_res = altar_res_
	sprite.texture = altar_res.texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sprite.modulate = curr_modulation_color
	var r: float = curr_modulation_color.r
	r = min(1.0, r * 1.05)
	var g: float = curr_modulation_color.g
	g = min(1.0, g * 1.05)
	var b: float = curr_modulation_color.b
	b = min(1.0, b * 1.05)
	curr_modulation_color = Color(r, g, b)

func indicate_correct() -> void:
	curr_modulation_color = Color(0.5, 1.0, 0.5)

func indicate_wrong() -> void:
	curr_modulation_color = Color(1.0, 0.5, 0.5)
