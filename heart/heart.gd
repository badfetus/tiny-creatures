extends Node2D
class_name Heart

const minHealth = 125.0
const maxHealth = 250.0
const noHealDuration = 3.0

var barrier = maxHealth
var healRate = 5.0

var lastDamageTime = -100.0
var currTime = 0.0
@onready var savegame = get_node("/root/Savegame")
var angle = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	currTime += delta
	$HeartCollider/CollisionShape2D.shape.radius = barrier
	
	handleHealing(delta)

func handleHealing(delta):
	if(barrier < maxHealth):
		if(currTime >= lastDamageTime + noHealDuration):
			barrier += healRate * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	angle += delta * 3
	handleHeartBeat()
	queue_redraw()

func handleHeartBeat():
	#var audioStream: AudioStreamPlayer = get_parent().get_node("AudioStreamPlayer")
	var time: float = currTime #audioStream.get_playback_position() + AudioServer.get_time_since_last_mix()
	#^commented out code is the proper way to do it but doesn't work on web build
	
	var beatTime: float = fmod(time - 0.1, 0.8)
	if(beatTime > 0.4):
		$Sprite2D.scale.x = 1
		$Sprite2D.scale.y = 1
	else:
		$Sprite2D.scale.x = 0.95
		$Sprite2D.scale.y = 0.95

func _draw() -> void:
	if(barrier >= minHealth):
		draw_circle(Vector2(0, -15), barrier, Color(1, 1, 1, 0.5), false, 1, true)
		draw_arc(Vector2(0, -15), barrier, angle, angle + PI / 2, 32, Color.WHITE, 5, true)

func damage(value: float):
	if(barrier < minHealth):
		loseGame()
		return
	lastDamageTime = currTime
	barrier -= value
	get_parent().combo = 0
	get_parent().updateUI(-1, -1, -1)
	
func loseGame():
	Savegame.score = get_parent().score
	var menuScene = load("res://other/MainMenu.tscn")
	get_tree().change_scene_to_packed(menuScene)
