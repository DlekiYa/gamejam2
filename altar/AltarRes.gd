extends Resource
class_name AltarRes

enum AltarType {OWL_ALTAR, ELDRICTCH_ALTAR}
@export var altar_type: AltarType
@export var name: String
@export var texture: Texture2D
@export var texture_trimmed: Texture2D

func check_requirements(items: Array[InvItem]) -> bool:
	match altar_type:
		AltarType.OWL_ALTAR:
			var stickcnt: int = 0
			for item: InvItem in items:
				if item == null:
					continue
				if item.name == "stick":
					stickcnt += 1
			return stickcnt >= 3
		AltarType.ELDRICTCH_ALTAR:
			return false
	return false
