extends Resource

class_name Inv

signal update

@export var slots: Array[InvSlots]

const item_on_ground_scene: PackedScene = preload("res://inventory/item_on_ground.tscn")

func insert(item: InvItem, slot: int, player: Player) -> bool:
	var emptyslots = slots.filter(func(slots): return slots.item == null)
	if !emptyslots.is_empty():
		emptyslots[0].item = item
	else:
		drop(slot, player)
		slots[slot].item = item
	update.emit()
	return true

func drop(slot: int, player: Player) -> bool:
	if slots[slot].item == null:
		return false
	else:
		var new_item: ItemOnGround = item_on_ground_scene.instantiate()
		player.get_tree().root.add_child(new_item)
		new_item.set_item_resource(slots[slot].item)
		slots[slot].item = null
		update.emit()
		new_item.position = player.global_position
		return true

func check_slot(slot: int) -> bool:
	return slots[slot] != null

func clear(slot: int, player: Player):
	if slots[slot].item == null:
		return false
	else:
		var new_item: ItemOnGround = item_on_ground_scene.instantiate()
		slots[slot].item = null
		update.emit()
		new_item.position = player.global_position
		return true
