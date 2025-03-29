extends Node

# TODO Check signals and func calls to avoid confusion

var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

var cur_day := "Monday"
var cur_classroom := ""

var scd : Dictionary


signal signal_day_changed


func _ready() -> void:
	for day in days:
		scd[day] = {} 


func set_classroom(classroom : String):
	cur_classroom = classroom


func set_cur_day(day_no : String):
	if cur_day != day_no:
		cur_day = day_no
		signal_day_changed.emit(scd[cur_day])
		print(scd[cur_day])


func period_select(period, classname):
	#print(cur_day + cur_classroom + classname +str(period))
	print("%s %s %s %s"%[cur_day, str(period+1), classname, cur_classroom])
	
	if classname not in scd[cur_day]:
		scd[cur_day][classname] = {}
	
	scd[cur_day][classname][period] = cur_classroom
	
	return cur_classroom
	

"""
scd = {
	"Monday" : {
		"BCA 2A" : {1 : 101, 2:110, 4:110},
		"BCA 2B" : {1 : 110, 2: 101}
	},
	"Tuesday" : {
		"BCA 2A" : {1 : 101, 2:110, 4:110},
		"BCA 2B" : {1 : 110, 2: 101}
	}
}

scd[cur_day][classname][period] = classroom_no



if classname not in scd[cur_day]:
	scd[cur_day][classname] = {}

scd[cur_day][classname][period] = classroom_no
"""
