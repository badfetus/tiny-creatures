extends Upgrade

var val: int

func getCurrentValue() -> String:
	return str(player.attackRange)

func getNewValue() -> String:
	val = randi_range(70, 130)
	return str(player.attackRange + val)

func getDescription() -> String:
	return "Attack Range Up"

func getName() -> String:
	return "Intervention"

func applyEffect() -> void:
	player.attackRange += val
