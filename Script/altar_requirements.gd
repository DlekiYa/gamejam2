extends PanelContainer
var altar_to_show_tip_of: AltarRes

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_altar(altar: AltarRes) -> void:
	altar_to_show_tip_of = altar
	$'VBoxContainer/Sprite'.texture = altar_to_show_tip_of.texture_trimmed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
