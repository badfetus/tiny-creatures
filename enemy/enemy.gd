extends CharacterBody2D
class_name Enemy

@onready var heart: Heart = get_parent().get_parent().get_node("Heart")
var experienceClass = preload("res://enemy/experience.tscn")

var speed = 100
var health = 80
var damage = 20
var score = 1

var expDropped = 5

var damageDealt = false

func _ready() -> void:
	motion_mode = MOTION_MODE_FLOATING
	
func _physics_process(_delta: float) -> void:
	var direction = (heart.position - position).normalized()
	velocity = direction * speed
	move_and_slide()
	
	handleCollisions()
	
func handleCollisions():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if(collision.get_collider().name == "HeartCollider"):
			if(!damageDealt):
				heart.damage(damage)
				damageDealt = true
				print("Damage dealt by: " + str(self.get_rid()))
			queue_free()

func takeDamage(damageTaken):
	health -= damageTaken
	if(health <= 0):
		die()

func die():
	get_parent().get_parent().enemyDied(score)
	dropXP()
	queue_free()
	
func dropXP():
	for i in expDropped:
		var experience = experienceClass.instantiate()
		experience.position = position
		experience.position.x += randf_range(-10, 10)
		experience.position.y += randf_range(-10, 10)
		experience.player = get_parent().get_parent().get_node("Player")
		get_parent().get_parent().add_child(experience)
