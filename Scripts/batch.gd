extends Control

 #Taking classroom data
@export var classrooms_li : Array[String]
# Taking class data
@export var classes_li : Array[String]

# Total number of periods
@export var periods := 4

# To show classroom list
@onready var classroom_panel = $MarginContainer/MainVBox/classrooms

var class_prefab = preload("res://Scene/class.tscn")

# Vertial box to store different class_prefabs
@onready var vbox = $MarginContainer/MainVBox/VBoxContainer


func _ready():
	# passing classroom data to classroom panel to generate classrooms
	classroom_panel.set_classrooms(classrooms_li)
	# setting up classes
	set_classes()
	
	# Connecting with signal, that fires whenever cur_day is switched, then we rebuild the board 
	DataManager.signal_day_changed.connect(setup_board)


# Creates classes from class data and make it child of vbox
func set_classes():
	for cur_class_name : String in classes_li:
		var new_class = class_prefab.instantiate() as class_manager
		vbox.add_child(new_class)
		# Setting class name and total periods to all classes
		new_class.set_class_and_period(cur_class_name, periods)


# Building and rebuilding the time table board
func setup_board(scd : Dictionary):
	for cur_class : class_manager in vbox.get_children():
		# getting name of class
		var cur_class_name : String = cur_class.get_class_name()
		
		# if cur_class is in schdule -> 
		if cur_class_name in scd:
			# fetch data and rebuild the board
			cur_class.set_board(scd[cur_class_name])
		
		# if cur_class is not in schdule
		else:
			# make the board empty
			cur_class.empty_board()
		
