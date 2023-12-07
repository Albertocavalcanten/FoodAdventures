#Script do botão de Pausa do jogo
extends Node

func _on_PauseButton_pressed():
	Transition.put_above("res://Scenes/Pause.tscn")
