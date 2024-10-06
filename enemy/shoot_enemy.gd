extends Enemy

var lastAttack = 0.0
var timeElapsed = 0.0
const attackRate = 2.0
var bulletClass = preload("res://enemy/EnemyBullet.tscn")
@onready var player: Player = get_parent().get_parent().get_node("Player")

func _ready() -> void:
	score += 4
	health += 20
	expDropped += 2
	speed -= 50

func _physics_process(delta: float) -> void:
	super(delta)
	timeElapsed += delta
	handleShooting()

func handleShooting():
	if(timeElapsed - lastAttack >= attackRate):
		lastAttack = timeElapsed
		var bullet = bulletClass.instantiate()
		var direction: Vector2 = (player.position - position).normalized()
		bullet.position = position + direction * 100
		bullet.direction = direction
		get_parent().get_parent().add_child(bullet)
