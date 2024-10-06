extends Upgrade

var val: int

func getCurrentValue() -> String:
	return str(player.extraBulletCount)

func getNewValue() -> String:
	val = 1
	return str(player.extraBulletCount + val)

func getDescription() -> String:
	return "Extra Bullet Count Up"

func getName() -> String:
	return "Multi-shot"

func applyEffect() -> void:
	player.extraBulletCount += val
