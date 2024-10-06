extends Upgrade

var val: int

func getCurrentValue() -> String:
	return str(player.attackSpeed)

func getNewValue() -> String:
	val = randi_range(10, 30)
	return str(player.attackSpeed + val)

func getDescription() -> String:
	return "Attack Speed Up"

func getName() -> String:
	return "Hyperstone"

func applyEffect() -> void:
	player.attackSpeed += val
