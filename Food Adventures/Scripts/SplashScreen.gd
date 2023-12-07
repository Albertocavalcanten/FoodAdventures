#Script da Splash Screen do jogo
extends Node
	
func _on_Timer_timeout():
	Transition.fade_to("res://Scenes/MainMenu.tscn")
