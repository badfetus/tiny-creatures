extends Node2D

var score: int = 0
var combo: int = 0
var scoreClass = preload("res://enemy/score/score.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func enemyDied(baseScore: int, deathPosition):
	var effectiveCombo = min(99, combo)
	score += baseScore * (1 + effectiveCombo)
	combo += 1
	updateUI(baseScore, effectiveCombo, deathPosition)
	
func updateUI(baseScore, effectiveCombo, deathPosition):
	$Camera2D/Control/Label.text = "Score: " + str(score)
	$Camera2D/Control/Label2.text = str(combo) + "x Combo"
	
	if(baseScore > 0):
		var scoreLabel = scoreClass.instantiate()
		scoreLabel.score = baseScore
		scoreLabel.mult = 1 + effectiveCombo
		scoreLabel.position = deathPosition
		add_child(scoreLabel)

func updateXpUi(experience, levelUpReq):
	var expUI: ColorRect = $Camera2D/Control/exp
	expUI.size.x = 1920 * experience / levelUpReq
