extends Node2D
class_name UpgradeHandler

@onready var player: Player = get_parent()
var allUpgrades: Array = Array()

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	allUpgrades.push_back(preload("res://upgrades/AttackSpeed.gd"))
	allUpgrades.push_back(preload("res://upgrades/Damage.gd"))
	allUpgrades.push_back(preload("res://upgrades/ExpAttract.gd"))
	allUpgrades.push_back(preload("res://upgrades/ExtraBullet.gd"))
	allUpgrades.push_back(preload("res://upgrades/Range.gd"))
	allUpgrades.push_back(preload("res://upgrades/Speed.gd"))

func handleUpgrade(_level: int):
	var upgrades: Array = Array()
	var possibleUpgrades: Array = Array()
	for upgrade in allUpgrades:
		possibleUpgrades.push_back(upgrade)
		
	for i in 3:
		var rand = randi_range(0, possibleUpgrades.size() - 1)
		upgrades.push_back(possibleUpgrades[rand])
		possibleUpgrades.remove_at(rand)
	$UpgradeMenu.handle(player, upgrades)
	get_tree().paused = true
