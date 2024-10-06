extends Upgrade

var val: int

func getCurrentValue() -> String:
	return str(player.damage)

func getNewValue() -> String:
	val = randi_range(30, 70)
	return str(player.damage + val)

func getDescription() -> String:
	return "Damage Up"

func getName() -> String:
	return "Tarakuja"

func applyEffect() -> void:
	player.damage += val
