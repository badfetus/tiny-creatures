extends Upgrade

var val: int

func getCurrentValue() -> String:
	return str(player.expAttractRange)

func getNewValue() -> String:
	val = randi_range(60, 100)
	return str(player.expAttractRange + val)

func getDescription() -> String:
	return "DNA attract range up"

func getName() -> String:
	return "Experience is key"

func applyEffect() -> void:
	player.expAttractRange += val
