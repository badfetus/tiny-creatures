extends Upgrade
class_name Evolution

var children: Array = Array()
func applyEffect() -> void:
	for child in children:
		upgradeHandler.upgrades.push_back(child)
