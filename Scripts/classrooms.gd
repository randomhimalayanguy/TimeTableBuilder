extends Panel

@onready var hbox := $HBoxContainer
var classroom_btn = preload("res://Scene/classroom_btn.tscn")

var classroom_btn_group = preload("res://extras/classroom_btn_group.tres")


func set_classrooms(classroom_list : Array[String]):
	for classroom in classroom_list:
		var btn = classroom_btn.instantiate() as Button
		btn.text = classroom
		btn.button_group = classroom_btn_group
		hbox.add_child(btn)
		btn.pressed.connect(_classroom_chosen.bind(classroom))


func _classroom_chosen(classroom : String):
	DataManager.set_classroom(classroom)
