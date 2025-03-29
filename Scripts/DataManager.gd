extends Node

# TODO Check signals and func calls to avoid confusion

var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

var cur_day := "Monday"
var cur_classroom := ""

var scd : Dictionary
var scd_classroom : Dictionary

signal signal_day_changed


func _ready() -> void:
	for day in days:
		scd[day] = {} 
		scd_classroom[day] = {}


func set_classroom(classroom : String):
	cur_classroom = classroom


func set_cur_day(day_no : String):
	if cur_day != day_no:
		cur_day = day_no
		signal_day_changed.emit(scd[cur_day])
		print(scd[cur_day])


func period_select(period, classname):
	# if classroom is not selected, return "" (do nothing)
	if cur_classroom == "":
		return ""
	
	# if classroom is already assigned to any other class, return "" (do nothing)
	if cur_classroom in scd_classroom[cur_day] and period in scd_classroom[cur_day][cur_classroom]:
		return ""
	
	# if we are assigning this classroom for the first time (on this day), then create structure
	if cur_classroom not in scd_classroom[cur_day]:
		scd_classroom[cur_day][cur_classroom] = []
	
	# if we are replacing a classroom
	# finding the previously assigned classroom using scd
	if classname in scd[cur_day] and period in scd[cur_day][classname]:
		var prev_classroom_name = scd[cur_day][classname][period]
		var index = scd_classroom[cur_day][prev_classroom_name].find(period)
		scd_classroom[cur_day][prev_classroom_name].remove_at(index)
	
	# adding period to that classroom, so that it will not be assigned to any other class
	scd_classroom[cur_day][cur_classroom].append(period)
	
	# if nothing has assigned to class on that day, create structure
	if classname not in scd[cur_day]:
		scd[cur_day][classname] = {}
	# assign classroom to the class on that period
	scd[cur_day][classname][period] = cur_classroom
	
	return cur_classroom


"""
Structure of dictionaries ->

scd -> { 
	String(Day) : { 
		String(Classname) : { 
			Integer(Period) : String(Classroom) 
			} 
		} 
	}

scd eg -> {
	Monday : {
		BCA2A : {1 : Lab5, 2 : Lab4},
		BCA4B : {1 : Lab4}
		},
	Tuesday : {
		BCA4B : {1 : Lab4}
	}
}

scd_classroom -> {
	String(Day) : {
		String(Classroom) : Array[Integer] (Array of periods)
	}
}

scd_classroom eg -> {
	Monday : {
		Lab5 : [1,2,3], 
		Lab8 : [3,1]
	}
}

"""
