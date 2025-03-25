extends Button


var has_clicked = false
signal btn_clicked

func btn_state():
	if not has_clicked:
		button_pressed = true
	else:
		button_pressed = false
	
	print(button_pressed)
	print("Working")
	has_clicked = !has_clicked
