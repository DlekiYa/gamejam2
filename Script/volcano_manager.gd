extends Node2D

class_name VolcanoManager

@export var volcano_textures: Array[Texture2D] # basically each index corresponds to a size texture
# now that I think about it, in the future we should assign scenes so that the collision shape is pre-made
@export var my_sprite: Sprite2D
var current_scale: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	my_sprite.texture = volcano_textures[current_scale]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
