extends Upgrade

var val: int

func _ready() -> void:
	val = randi_range(20, 60)

func getCurrentValue() -> String:
	return str(player.auraRadius)

func getNewValue() -> String:
	return str(player.auraRadius + val)

func getDescription() -> String:
	return "Aura radius up"

func getName() -> String:
	return "Experience is key"

func applyEffect() -> void:
	player.expAttractRange += val
