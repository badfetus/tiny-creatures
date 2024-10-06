extends Evolution

func _ready() -> void:

func getCurrentValue() -> String:
	return str(player.expAttractRange)

func getNewValue() -> String:
	return str(player.expAttractRange + val)

func getDescription() -> String:
	return "DNA attract range up"

func getName() -> String:
	return "Experience is key"

func applyEffect() -> void:
	player.expAttractRange += val
