extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_desplace
@onready var amount_text: Label = $CenterContainer/Panel/Label

func update(slot: InvSlots):
	if slot.item == null:
		item_visual.visible = false
		amount_text.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
	
