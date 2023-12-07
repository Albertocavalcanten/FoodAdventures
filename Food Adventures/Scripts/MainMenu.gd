#Script de funções do Menu Principal
extends Node

func _ready():
	if Transition.soundState == true:
		get_node("MenuSoundtrack").play()

func _on_PlayButton_pressed():
	Transition.fade_to("res://Scenes/Game.tscn")

func _on_SoundButton_pressed():
	if Transition.soundState == true:
		get_node("MenuSoundtrack").stop()
		Transition.soundState = false
	elif Transition.soundState == false:
		get_node("MenuSoundtrack").play()
		Transition.soundState = true
