extends CharacterBody2D
class_name Player

var bulletClass = preload("res://player/PlayerBullet.tscn")
@onready var enemies = get_parent().get_node("Enemies")
const baseAttackRate = 250.0

var speed = 300
var attackRange = 400
var attackSpeed = 100
var damage = 100
var expAttractRange = 100
var extraBulletCount = 0

var lastAttack = 0.0
var timeElapsed = 0.0

var stunned = false
var stunLeft = 0.0
var invulnLeft = 0.0

var is_moving: bool = false

var experience = 0
var levelUpReq = 7
var levelUpReqPerLevel = 5

var hasAura = false
var auraDamage = 20
var auraRadius = 150

var hasExplosion = false
var explosionChance = 0
var explosionRadius = 0

var hasFlames = false
var flameDamage = 0
var flameChance = 0

var hasFreeze = false
var freezeChance = 0
var freezeAmount = 0

var hasLightning = false
var lightningChance = 0
var lightningCount = 0

var hasPoison = false
var poisonDamage = 0
var posionRadius = 0

var level = 0

func _ready() -> void:
	motion_mode = MOTION_MODE_FLOATING

func _physics_process(delta):
	timeElapsed += delta 
	handleShooting()
	handleMovement()

func handleMovement():
	var up = Input.get_action_strength("down") - Input.get_action_strength("up") 
	var right = Input.get_action_strength("right") - Input.get_action_strength("left")
		
	var movement = Vector2(right, up)
	if(movement.length_squared() > 1):
		movement = movement.normalized()
	
	velocity = movement * speed
	move_and_slide()


func handleShooting():
	var attackCount = int((timeElapsed - lastAttack) / (baseAttackRate / attackSpeed))
	var target
	var closestTargetDist = 99999999
	if(attackCount > 0 and enemies.get_child_count() > 0):
		for enemy in enemies.get_children():
			var distance = (enemy.position - position).length_squared()
			if(closestTargetDist > distance):
				closestTargetDist = distance
				target = enemy
		attackCount += extraBulletCount
	elif(enemies.get_child_count() == 0):
		lastAttack = timeElapsed - (baseAttackRate / attackSpeed) #can't save attacks but you get a bonus
		return
	else:
		return
	for i in attackCount:
		lastAttack = timeElapsed
		var angleFuzzing = i * (2 * PI / attackCount)
		var bullet = bulletClass.instantiate()
		var direction: Vector2 = (target.position - position).normalized()
		direction = direction.rotated(angleFuzzing)
		bullet.position = position + direction * 100
		bullet.direction = direction
		bullet.maxRange = attackRange
		bullet.damage = damage
		get_parent().add_child(bullet)

func addExperience():
	experience += 1
	updateXpUi()
	while(experience >= levelUpReq):
		levelUp()
	
func levelUp():
	experience -= levelUpReq
	levelUpReq += levelUpReqPerLevel
	level += 1
	$UpgradeHandler.handleUpgrade(level)
	updateXpUi()

func updateXpUi():
	get_parent().updateXpUi(experience, levelUpReq)
	
func getKnocked(direction):
	velocity = 10000 * direction.normalized()
	move_and_slide()
	
