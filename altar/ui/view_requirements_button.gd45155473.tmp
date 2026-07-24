extends PanelContainer
class_name ViewRequirementsButton

@export var altar_to_display: AltarRes
@export var my_player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if altar_to_display != null:
		$Button.icon = altar_to_display.texture_trimmed
	my_player = get_node("../../../../Player")

func set_altar_res(altar_res: AltarRes) -> void:
	altar_to_display = altar_res
	$Button.icon = altar_to_display.texture_trimmed

func _on_mouse_entered() -> void:
	my_player.diplay_altar_tip(altar_to_display)


func _on_mouse_exited() -> void:
	my_player.hide_altar_tip()
