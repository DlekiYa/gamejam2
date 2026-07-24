extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_desplace

func update(slot: InvSlots):
	if slot.item == null:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
	
