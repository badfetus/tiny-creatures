extends HTTPRequest

func _on_HTTPRequest_request_completed( result, response_code, headers, body ):
	var jsonInstance = JSON.new()
	var json = json.parse(body.get_string_from_utf8())
	#print(json.result)
	var leaderboard = get_node('/root/Node2D/Label')
	leaderboard.set_text(str(body.get_string_from_utf8()))
	if body.get_string_from_utf8() == "":
		leaderboard.set_text("You need to connect to the internet to view the leaderboard.")
