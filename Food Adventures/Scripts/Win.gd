#Script de funções de vitória do jogo
extends Node2D

func _ready():
	get_node("WinAnimation").play("in")
	get_node("WinBackground/Score").set_text("Pontos: " + str(Transition.level - 1) + "00")
	get_node("WinBackground/CuriosityText").set_bbcode(Transition.content)

func _on_Timertitle_timeout():
	get_node("WinBackground/CuriosityTitle").show()
	get_node("WinBackground/CuriosityText/TimerText").start()

func _on_TimerText_timeout():
	get_node("WinBackground/CuriosityText").show()
	get_node("WinBackground/ContinueButton/TimerButton").start()

func _on_TimerButton_timeout():
	get_node("WinBackground/ContinueButton").show()

func _on_ContinueButton_pressed():
	get_node("WinAnimation").play("out")
	yield(get_node("WinAnimation"), "animation_finished")
	#mecanismo de reinício dos níveis e encaminhamento ao fim de jogo
	if Transition.level > 5:
		Transition.level = 1
		Transition.fade_to("res://Scenes/End.tscn")
		Transition.clear_above()
	else:
		Transition.fade_to("res://Scenes/Game.tscn")
		Transition.clear_above()

func _on_MenuButton_pressed():
	get_node("WinAnimation").play("out")
	yield(get_node("WinAnimation"), "animation_finished")
	Transition.fade_to("res://Scenes/MainMenu.tscn")
	Transition.clear_above()
