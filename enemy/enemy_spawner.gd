extends Node2D

@onready var enemies = get_parent().get_node("Enemies")
var enemyClass = preload("res://enemy/enemy.tscn")
var enemyClass2 = preload("res://enemy/shootEnemy.tscn")
var enemyClass3 = preload("res://enemy/covidEnemy.tscn")

var totalSpawns = 0
var spawnType = 0
var spawnTime = 3.0
var timePassed = 0.0
var visualTimePassed = 0.0

func _physics_process(delta: float) -> void:
	timePassed += delta
	if(timePassed >= spawnTime):
		spawn()

func _process(delta: float) -> void:
	visualTimePassed += delta
	queue_redraw()

func _draw() -> void:
	var color = Color.DIM_GRAY
	if(spawnType == 1): color = Color.DODGER_BLUE
	elif(spawnType == 2): color = Color.LIME_GREEN
	
	draw_circle(Vector2(0, 0), 75, color, false, 1, true)
	var arcSize = visualTimePassed / spawnTime
	if(arcSize > 1):
		arcSize = 1
	draw_arc(Vector2(0, 0), 75, 0, 2 * PI * arcSize, 32, color, 5, true)
	
func spawn():
	var enemyType
	
	if(spawnType == 0): enemyType = enemyClass
	elif(spawnType == 1): enemyType = enemyClass2
	elif(spawnType == 2): enemyType = enemyClass3
	
	var enemy = enemyType.instantiate()
	enemy.position = position
	if(spawnType == 0):
		enemy.health += totalSpawns * 5
	elif(spawnType == 1):
		enemy.health += totalSpawns * 3
	else:
		enemy.health += totalSpawns
	enemies.add_child(enemy)
	queue_free()
