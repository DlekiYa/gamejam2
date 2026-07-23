extends Control

@onready var inv: Inv = preload("res://inventory/Player_inventory.tres")
@onready var slots: Array = $GridContainer.get_children()


func _ready() -> void:
	inv.update.connect(update_slots)
	update_slots()

func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])




	
