#extends Panel
#
## label -> class name (like BCA 2 A)
#@onready var label := $Label
#@onready var hor_box := $HBoxContainer
#
## stores the text passed using set_classroom function
#var btn_text := ""
#
#var total_classes := 4
#
## loading period_btn prefab
#var period_btn = preload("res://Scene/period_button.tscn")
#
## for re-emitting the signal
#signal period_chosen
#
#
#var scd := {} 
#var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
#
#func _ready():
	#for day in days:
		#scd[day] = {}
#
#
## to create as many period_btn as there are periods, called by batch.gd
#func set_periods(total_periods):
	#for i in range(total_periods):
		## creating btn object and adding it
		#var btn = period_btn.instantiate() as Button
		#hor_box.add_child(btn)
		#
		## call _chosen func when button is pressed, pass current button index and the button itself
		#btn.pressed.connect(_chosen.bind(i, btn))
#
#
## called by batch.gd
#func set_label_name(name=""):
	#label.text = name
#
#
## after listening to the signal, batch.gd, call this function (2)
#func set_classroom(name_class):
	#btn_text = name_class
#
#
#func disable_btns():
	#for btn in hor_box.get_children():
		#btn.disabled = true
#
#func enable_btns():
	#for btn in hor_box.get_children():
		#btn.disabled = false
#
#
#func disable_clashes(arr : Array):
	#for i in range(hor_box.get_child_count()):
		#if i in arr and hor_box.get_child(i).text == "":
			#hor_box.get_child(i).disabled = true
#
#
#
#func check_collision(day:String, period, classroom:String):
	#if period in scd[day]:
		#return true
	#return false
#
#
#func set_scd(day:String, period, classroom:String):
	#scd[day] = {period : classroom}
#
#
## when button is pressed, emit the period_chosen signal and index of the button
#func _chosen(i, btn:Button):
	## the signal is emitted (1)
	#period_chosen.emit(i)
	## after set_classroom func is called, we change text of button (3)
	#btn.text = btn_text
	#total_classes -= 1
	#btn_text = ""
