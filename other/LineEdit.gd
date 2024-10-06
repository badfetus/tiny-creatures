extends LineEdit

var allowed_chars = "qwertyuiopasdfghjklzxcvbnm0123456789QWERTYUIOPASDFGHJKLZXCVBNM" 

func _physics_process(_delta):
	var validated = ""
	for letter in text:
		if(allowed_chars.contains(letter)):
			validated += letter
	if(validated != text):
		text = validated
