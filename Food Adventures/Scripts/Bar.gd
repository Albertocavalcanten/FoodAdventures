#Script de funções da barra de tempo de jogo
extends Node2D

onready var marker = get_node("Marker")

var start = false
var loses = 1

signal lost

func _ready():
	set_process(true)

func _process(delta):
	if start:
		if loses > 0:
			#tempo estimado para cada nível
			loses -= 0.015*delta
			#cálculo feito com base no tempo de fase e tamanho da barra de tempo
			marker.set_region_rect(Rect2(0, 0, loses*408, 42))
		else:
			emit_signal("lost")

func _on_BarTimer_timeout():
	start = true

func _on_ConfirmButton_pressed():
	get_node("BarTimer").start()
