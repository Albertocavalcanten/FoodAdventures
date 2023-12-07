#Script de funções de fim de jogo
extends Node2D

func _on_TimerText_timeout():
	get_node("EndBackground/ContentText").show()
	get_node("EndBackground/EndButton/TimerButton").start()

func _on_TimerButton_timeout():
	get_node("EndBackground/EndButton").show()

func _on_EndButton_pressed():
	Transition.fade_to("res://Scenes/MainMenu.tscn")
