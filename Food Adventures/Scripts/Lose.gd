#Script de funções de derrota do jogo
extends Node2D

func _ready():
	get_node("LoseAnimation").play("in")
	get_node("LoseBackground/Score").set_text("Pontos: " + str(Transition.level - 1) + "00")

func _on_AgainTimer_timeout():
	get_node("LoseBackground/AgainText").show()

func _on_AgainButton_pressed():
	get_node("LoseAnimation").play("out")
	yield(get_node("LoseAnimation"), "animation_finished")
	Transition.fade_to("res://Scenes/Game.tscn")
	Transition.clear_above()

func _on_MenuButton_pressed():
	get_node("LoseAnimation").play("out")
	yield(get_node("LoseAnimation"), "animation_finished")
	Transition.fade_to("res://Scenes/MainMenu.tscn")
	Transition.clear_above()
