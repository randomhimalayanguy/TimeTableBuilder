extends HBoxContainer

var cur_selected = ""
var group

func _ready() -> void:
	group = ButtonGroup.new()
	for btn in get_children():
		if btn is Button:
			btn.add_to_group("group", true)
			btn.pressed.connect(_btn_pressed.bind(btn.text))


func _btn_pressed(name):
	self.add_theme_color_override("color", Color.RED)
	if cur_selected != name:
		cur_selected = name
		print(cur_selected)
	else:
		cur_selected = ""
	


func _input(event):
	if event.is_action_pressed("space"):
		print("Pressed ")
		
