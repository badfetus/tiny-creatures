extends CharacterBody2D

var speed = 500
var attracted = false
var player: Player

func _physics_process(_delta: float) -> void:
	if(!attracted):
		var playerDist = (player.position - position).length()
		if(playerDist <= player.expAttractRange):
			attracted = true
	
	if(attracted):
		velocity = (player.position - position).normalized() * speed
		move_and_slide()
		handleCollisions()
	
func handleCollisions():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if(collision.get_collider().name == "Player"):
			player.addExperience()
			queue_free()
			return

func _draw() -> void:
	draw_circle(Vector2(0, 0), 2, Color.GOLD, true, -1.0, true)
