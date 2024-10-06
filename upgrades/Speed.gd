extends Upgrade

var val: int
	

func getCurrentValue() -> String:
	return str(player.speed)

func getNewValue() -> String:
	val = randi_range(25, 75)
	return str(player.speed + val)

func getDescription() -> String:
	return "Movement Speed Up"

func getName() -> String:
	return "Gotta Go Faster"

func applyEffect() -> void:
	player.speed += val
