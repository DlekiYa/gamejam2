extends Node2D
class_name Altar

@export var altar_res: AltarRes
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if altar_res != null:
		$AltarSprite.texture = altar_res.texture


func set_altar_res(altar_res_: AltarRes) -> void:
	altar_res = altar_res_
	$AltarSprite.texture = altar_res.texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
