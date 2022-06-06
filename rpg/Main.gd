extends Node2D

var novabomba = preload("res://bomba.tscn")
func _ready():
	pass




func _on_Player_criabomba():
	var bomba = novabomba.instance()
	add_child(bomba)
	bomba.position.x = $Player.retx()
	bomba.position.y = $Player.rety()
