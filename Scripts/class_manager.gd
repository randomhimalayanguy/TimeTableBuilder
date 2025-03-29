extends Panel

class_name class_manager

@onready var name_of_class = $Label as Label
var period_btn = preload("res://Scene/period_button.tscn")
@onready var hbox = $HBoxContainer


func set_class_and_period(classname : String, period : int):
	name_of_class.text = classname
	set_periods(period)


func set_periods(periods : int):
	for i in range(periods):
		var btn = period_btn.instantiate() as Button
		hbox.add_child(btn)
		btn.pressed.connect(_period_chosen.bind(i, btn))


func _period_chosen(i, btn):
	btn.text = DataManager.period_select(i, name_of_class.text)


func get_class_name():
	return name_of_class.text


func set_board(board):
	for i in range(hbox.get_child_count()):
		var btn = hbox.get_child(i) 
		if i in board:
			btn.text = board[i]
			btn.button_pressed = true
		else:
			btn.text = ""
			btn.button_pressed = false


func empty_board():
	for btn in hbox.get_children():
		btn.text = ""
		btn.button_pressed = false
