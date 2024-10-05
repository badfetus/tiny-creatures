extends Node2D

var barrier = 250

var angle = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	angle += delta * 3
	queue_redraw()

func _draw() -> void:
	draw_circle(Vector2(0, 0), barrier, Color(1, 1, 1, 0.5), false, 1, true)
	draw_arc(Vector2(0, 0), barrier, angle, angle + PI / 2, 32, Color.WHITE, 5, true)
