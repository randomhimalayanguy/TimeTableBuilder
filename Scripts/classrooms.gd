extends Panel

# Getting reference to the horizontal box, for layout
@onready var hor_box := $HBoxContainer
# loading classroom btn
var classroom_btn = preload("res://Scene/classroom_btn.tscn")

var classroom_group = preload("res://extras/classroom_btn_group.tres")

signal classroom_selected

var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

var scd := {}


func _ready():
	for day in days:
		scd[day] = {}


# This function is called by batch.gd _ready() function
func set_classrooms(classrooms): # classrooms -> Array[String]
	# We are creating len(classrooms) number of buttons
	for i in range(len(classrooms)):
		# Create a button and add it to hor_box
		var btn = classroom_btn.instantiate() as Button
		hor_box.add_child(btn)
		
		# Storing current classroom number in a string
		var classroom_no = classrooms[i]
		# Setting current button text as classroom_no
		btn.text = classroom_no
		btn.button_group = classroom_group
		
		# Connecting the button's pressed signal, with a function _chosen and using .bind() to pass arg
		btn.pressed.connect(_chosen.bind(classroom_no))



#func check_collision(day:String, period, classname:String):
	#if period in scd[day]:
		#return true
	#return false
#
#
#func set_scd(day:String, period, classname:String):
	#scd[day] = {period:classname}
#
#
# When btn is pressed, emit the signal along with classroom_no
func _chosen(classroom_no):
	classroom_selected.emit(classroom_no)
