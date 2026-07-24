extends Label

class_name LabelTip
enum State {PICK_UP, PUT_ON_GRID, ACTIVATE, HIDDEN}
var current_state: State = State.HIDDEN
var states_deque: Array[State]

# Called when the node enters the scene tree for the first time.
func update() -> void:
	if states_deque.size() == 0:
		current_state = State.HIDDEN
	else:
		current_state = states_deque.back()
	match current_state:
		State.PICK_UP:
			text = "press 'F' to pick up"
			show()
		State.PUT_ON_GRID:
			text = "press 'X' to drop on grid"
			show()
		State.ACTIVATE:
			text = "press 'E' to sacrifice"
			show()
		State.HIDDEN:
			hide()

func add_state(state: State) -> void:
	states_deque.append(state)
	update()

func remove_state(state: State) -> void:
	states_deque.erase(state)
	update()
