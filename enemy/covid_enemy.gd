extends Enemy

class_name covid

var lastAttack = 0.0
var timeElapsed = 0.0
const attackRate = 4.0
var size
@onready var player: Player = get_parent().get_parent().get_node("Player")
var covidClass = preload("res://enemy/covidEnemy.tscn")

func _ready() -> void:
	score += 4
	health += 20
	expDropped += 15
	speed = 0
	size = 40
	damage *= 2
	
func _physics_process(delta: float) -> void:
	var randAngle = (randf_range(0, 10) - 5) / 360.0 * PI * 2
	var direction = (heart.position - position).normalized()
	direction = direction.rotated(randAngle)
	velocity = direction * speed
	move_and_slide()
	
	handleCollisions()
	if(speed == 0):
		timeElapsed += delta
		handleShooting()
	else:
		size += delta * 10
		if(size >= 40):
			size = 40
			speed = 0
		$Sprite2D.scale.x = 0.32 * size / 40
		$Sprite2D.scale.y = 0.32 * size / 40
		$CollisionShape2D.shape.radius = size

func handleShooting():
	if(timeElapsed - lastAttack >= attackRate):
		lastAttack = timeElapsed
		var covidJR: covid = covidClass.instantiate()
		var direction: Vector2 = (player.position - position).normalized()
		covidJR.position = position + direction * 60
		get_parent().add_child(covidJR)
		covidJR.speed = 150
		covidJR.expDropped = 0
		covidJR.score = 0
		covidJR.size = 20
		covidJR.find_child("Sprite2D").scale.x = 0.32 * covidJR.size / 40
		covidJR.get_node("Sprite2D").scale.y = 0.32 * covidJR.size / 40
		covidJR.get_node("CollisionShape2D").shape.radius = covidJR.size
