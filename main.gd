extends Node

func newGame():
	$kinematicPlayer.start($startPosition.position)

func _ready():
	newGame()
