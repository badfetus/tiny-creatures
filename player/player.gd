extends CharacterBody2D

var speed = 300.0

var is_moving: bool = false

func _physics_process(_delta):
	var up = Input.get_action_strength("down") - Input.get_action_strength("up") 
	var right = Input.get_action_strength("right") - Input.get_action_strength("left")
		
	var movement = Vector2(right, up)
	if(movement.length_squared() > 1):
		movement = movement.normalized()
	
	velocity = movement * speed
	
	move_and_slide()
