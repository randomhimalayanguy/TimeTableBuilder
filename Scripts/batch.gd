extends Control


var class_prefab = preload("res://Scene/class.tscn")
@onready var vbox_classes = $MarginContainer/MainVBox/VBoxContainer
@onready var classrooms_panel = $MarginContainer/MainVBox/classrooms
@onready var day_panel = $MarginContainer/MainVBox/Days

#var schd : Array[String]
var classroom_scd : Dictionary[String, Dictionary] = {}

# Stores current classroom
var classroom_detail : String
var cur_classroom = null

# Stores current day
var cur_day := "Monday"

var days : Array

# total number of periods
@export var total_periods := 4

# array of classrooms -> 110, 112, 101, etc.
@export var classrooms : Array[String]
# array of classes -> BCA 2A, BCA 4A, etc.
@export var classes : Array[String] 


func _ready() -> void:
	add_classes()
	add_classrooms()
	set_classroom("")
	day_panel.connect("day_selected", set_day)
	days = day_panel.get_days()
	for i in days:
		classroom_scd[i] = {} 


# pass classroom array to the classroom panel and connects with it's signal
func add_classrooms():
	classrooms_panel.set_classrooms(classrooms)
	classrooms_panel.connect("classroom_selected", set_classroom)


func set_day(day):
	cur_day = day
	print("Day " + cur_day)


# add classes based on classes array
func add_classes():
	for i in range(len(classes)):
		# Creating and adding a new class
		var _class = class_prefab.instantiate()
		vbox_classes.add_child(_class)
		# setting name of that class using classes array
		_class.set_label_name(classes[i])
		# setting total number of periods
		_class.set_periods(total_periods)
		
		# connecting with period_chosen signal and calling class_and_period func and passing
		# i -> index and _class object
		_class.connect("period_chosen", class_and_period.bind(i, _class))


# when classroom btn is pressed, we store that classroom detail
func set_classroom(classroom : String):
	classroom_detail = classroom if classroom != classroom_detail else ""
	#if classroom_detail == "":
		#for classes in vbox_classes.get_children():
			#classes.disable_btns()
	#else:
		#for classes in vbox_classes.get_children():
			#classes.enable_btns()
			#if classroom_scd[cur_day].has(classroom_detail):
				#classes.disable_clashes(classroom_scd[cur_day][classroom_detail])
	print(classroom_detail)


# when period_chosen signal occur 
# period -> already passed with period_chosen signal, cur_class (index) and _class obj is passed here
func class_and_period(period, cur_class, _class):
	# detail string
	var x = classes[cur_class] + " " +str(period+1) + " " + classroom_detail
	
	if classroom_detail != "":
		if not classroom_scd[cur_day].has(classroom_detail):
			classroom_scd[cur_day][classroom_detail] = []
		
		if period not in classroom_scd[cur_day][classroom_detail]:
			classroom_scd[cur_day][classroom_detail].append(period)
			_class.set_classroom(classroom_detail)
			#for classes in vbox_classes.get_children():
				#classes.disable_clashes(classroom_scd[cur_day][classroom_detail])
			print(x)
	


# Make changes here, check collision in class.gd and classroom.gd
#func class_and_period(period, cur_lass, _class):
	#pass
