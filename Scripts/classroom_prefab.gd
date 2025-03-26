extends Button

var scd := {}

var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

func _ready():
	for day in days:
		scd[day] = {}



func is_valid(day, period):
	if scd[day][period] == null:
		return true
	return false
