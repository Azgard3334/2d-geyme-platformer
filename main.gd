extends Node

func new_game():
	$player.start($startPosition.position)

func _ready():
	new_game()
