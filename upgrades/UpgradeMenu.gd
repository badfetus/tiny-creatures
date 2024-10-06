extends ColorRect

var upgradeUIs: Array = Array()
var upgradeInstances = Array()

# Called when the node enters the scene tree for the first time.
func _ready():
	upgradeUIs.push_back(find_child("0"))
	upgradeUIs.push_back(find_child("1"))
	upgradeUIs.push_back(find_child("2"))
	
	process_mode = Node.PROCESS_MODE_ALWAYS
	upgradeUIs[0].find_child("Pick").pressed.connect(pick0)
	upgradeUIs[1].find_child("Pick").pressed.connect(pick1)
	upgradeUIs[2].find_child("Pick").pressed.connect(pick2)
	self.visible = false
	

func handle(player: Player, upgrades: Array):
	self.visible = true
	upgradeInstances.clear()
	for i in 3:
		var upgrade = upgrades[i]
		var upgradeInstance: Upgrade = upgrade.new()
		upgradeInstances.push_back(upgradeInstance)
		upgradeInstance.player = player
		upgradeUIs[i].find_child("Name").text = upgradeInstance.getName()
		upgradeUIs[i].find_child("Description").text = upgradeInstance.getDescription()
		upgradeUIs[i].find_child("Value").text = upgradeInstance.getCurrentValue() + "->" + upgradeInstance.getNewValue()

func pick0():
	pick(0)
	
func pick1():
	pick(1)
	
func pick2():
	pick(2)

func pick(selection):
	get_tree().paused = false
	self.visible = false
	upgradeInstances[selection].applyEffect()
