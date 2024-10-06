extends Node2D

var score: int = 0
var combo: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func enemyDied(baseScore: int):
	var effectiveCombo = min(99, combo)
	score += baseScore * (1 + effectiveCombo)
	combo += 1
	updateUI()
	
func updateUI():
	$Camera2D/Control/Label.text = "Score: " + str(score)
	$Camera2D/Control/Label2.text = str(combo) + "x Combo"

func updateXpUi(experience, levelUpReq):
	var expUI: ColorRect = $Camera2D/Control/exp
	expUI.size.x = 1920 * experience / levelUpReq
