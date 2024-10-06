extends ColorRect

var game = preload("res://game/level.tscn")
@onready var lineEdit = $LineEdit
@onready var savegame = get_node("/root/Savegame")
var update = false
# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	var button = find_child("PlayButton") 
	button.pressed.connect(loadGame)
	$HTTPRequest.connect("request_completed", _on_HTTPRequest_request_completed)
	if(savegame.score >= 0):
		$LastScore.text = "Last Score: " + str(savegame.score)
		$LineEdit.text = savegame.player_name
		$HTTPRequest.request("https://www.dreamlo.com/lb/Kk39kpkSjEurbd-FoyvohgwoTXUVSsSUGVDW6MwtWesQ/add/" + savegame.player_name + "/" + str(savegame.score))
		savegame.score = -1
		update = true
	else:
		$HTTPRequest.request("https://www.dreamlo.com/lb/6701c3cc8f40c6124c16d364/json")
	
func _on_HTTPRequest_request_completed(_result, _response_code, _headers, body):
	if(update):
		update = false
		$HTTPRequest.request("https://www.dreamlo.com/lb/6701c3cc8f40c6124c16d364/json")
		return
	var json = JSON.new()
	var parse_result = json.parse(body.get_string_from_utf8())
	if parse_result == OK:
		var dict: Dictionary = json.get_data()
		print(dict)
		print("____________")
		if(dict):
			var leaderboard = dict.get("dreamlo").get("leaderboard").get("entry")
			var string = "[center]Leaderboard:\n"
			var idx = 1
			for entry in leaderboard:
				string += "[color=crimson]" + str(idx) + ".[/color] " 
				string += "[color=orange]" + entry.get("name") + ":[/color] "
				string += "[color=olive]" + entry.get("score") + "[/color]\n"
				idx += 1
			$Leaderboard.text = string


func loadGame():
	var playerName: String = lineEdit.text
	if playerName.length() <= 0:
		return
	get_tree().paused = false
	Savegame.player_name = playerName
	get_tree().change_scene_to_packed(game)
