extends CharacterBody2D

var speed = 1000
var radius = 1
var direction

func _physics_process(_delta: float) -> void:
	velocity = direction.normalized() * speed
	move_and_slide()
	handleCollisions()

func handleCollisions():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if(collision.get_collider().collision_layer == 4):
			var player: Player = collision.get_collider()
			player.getKnocked(direction)
		queue_free()
		return

func _draw() -> void:
	draw_circle(Vector2(0, 0), 5, Color(0, 0, 1), true, -1.0, true)
