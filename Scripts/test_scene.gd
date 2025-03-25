extends Panel

var btn : Button

func _ready() -> void:
	btn = get_child(0)
	btn.pressed.connect(change_state)


func change_state():
	btn.btn_state()
