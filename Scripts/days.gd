extends Panel

@onready var hbox := $HBoxContainer
var day_btn = preload("res://Scene/day_btn.tscn")
var btn_group = preload("res://extras/day_btn_group.tres")

var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]


func _ready():
	add_btn(days[0], true)
	for i in range(1, len(days)):
		add_btn(days[i], false)


func add_btn(day, set_default):
	var btn = day_btn.instantiate() as Button
	hbox.add_child(btn)
	btn.text = day
	btn.button_pressed = set_default
	btn.button_group = btn_group
	btn.pressed.connect(_day_chosen.bind(day))


func get_days():
	return days


func _day_chosen(cur_day):
	DataManager.set_cur_day(cur_day)
