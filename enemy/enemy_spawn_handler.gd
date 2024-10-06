extends Node2D
@onready var enemies = get_parent().get_node("Enemies")
var spawnerClass = preload("res://enemy/EnemySpawner.tscn")

var timeSinceLastSpawn = 0.0
var spawnTime = 3.0
var nextSpawn = spawnTime

var totalSpawns = 0

func _physics_process(delta: float) -> void:
	pass
	timeSinceLastSpawn += delta

	while(timeSinceLastSpawn >= nextSpawn):
		timeSinceLastSpawn -= nextSpawn
		spawnTime *= 0.99
		spawnEnemy()
		nextSpawn = spawnTime * randf_range(0.8, 1.2)
		
func spawnEnemy():
	var spawner = spawnerClass.instantiate()
	var x = 100 + (randi() % 350) - 960
	var y = 200 + (randi() % 780) - 540
	
	if((randi() % 2) == 1): #Right
		x = -x

	spawner.position = Vector2(x, y)
	var rand = randi() % 100
	var spawnType = 0
	if(totalSpawns >= 50):
		if(rand >= 60):
			spawnType = 2
		elif(rand >= 20):
			spawnType = 1
	elif(totalSpawns >= 25):
		if(rand >= 70):
			spawnType = 2
		elif(rand >= 30):
			spawnType = 1
	elif(totalSpawns >= 15):
		if(rand >= 85):
			spawnType = 2
		elif(rand >= 50):
			spawnType = 1
	elif(totalSpawns >= 5):
		if(rand >= 70):
			spawnType = 1
	
	spawner.spawnType = spawnType
	spawner.totalSpawns = totalSpawns
	get_parent().add_child(spawner)
	totalSpawns += 1
	
