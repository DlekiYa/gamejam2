extends Resource
class_name AltarRes

@export var name: String
@export var texture: Texture2D
@export var texture_trimmed: Texture2D

func check_requirements(items: Array[InvItem]) -> bool:
	push_warning("Calling checker of abstract altar. Dangerous")
	return true
