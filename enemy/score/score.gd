extends Node

const maxTime = 1.5
var timePassed = 0

var score: int
var mult: int

func _ready() -> void:
	$Label.text = str(mult) + " x " + str(score)
	

func _physics_process(delta: float) -> void:
	timePassed += delta
	$Label.position.y -= delta * 100/maxTime
	if(timePassed > maxTime):
		queue_free()
	
