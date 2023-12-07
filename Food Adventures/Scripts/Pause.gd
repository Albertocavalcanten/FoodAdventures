#Script de funções de Pausa do jogo
extends Node2D

func _on_ReturnButton_pressed():
	get_node("PauseAnimation").play("hide")
	yield(get_node("PauseAnimation"), "animation_finished")
	Transition.clear_above()

func _on_MenuButton_pressed():
	get_node("PauseAnimation").play("hide")
	yield(get_node("PauseAnimation"), "animation_finished")
	Transition.fade_to("res://Scenes/MainMenu.tscn")
	Transition.clear_above()

func _on_ReplayButton_pressed():
	get_node("PauseAnimation").play("hide")
	yield(get_node("PauseAnimation"), "animation_finished")
	Transition.fade_to("res://Scenes/Game.tscn")
	Transition.clear_above()
