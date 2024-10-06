extends CharacterBody2D

var speed = 500
var direction
var maxRange
var distanceTravelled = 0
var damage

func _physics_process(delta: float) -> void:
	velocity = direction.normalized() * speed
	move_and_slide()
	handleCollisions()
	
	distanceTravelled += speed * delta
	if(distanceTravelled > maxRange):
		queue_free()
	
func handleCollisions():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if(collision.get_collider().collision_layer == 8):
			var enemy: Enemy = collision.get_collider()
			enemy.takeDamage(damage)
		queue_free()
		return

func _draw() -> void:
	draw_circle(Vector2(0, 0), 5, Color(1, 1, 1), true, -1.0, true)
