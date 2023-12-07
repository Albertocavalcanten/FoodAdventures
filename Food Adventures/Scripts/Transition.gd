#Script de Parâmetros de transição e gerais do jogo
extends CanvasLayer

#Parâmetros de transição
var nextScenePath
var aboveNode

#parâmetros de configurações gerais
var level #controlador dos niveis do jogo
var content #conteúdo informativo apresentado ao jogador
var soundState = true #controlador de som do jogo

func fade_to(path):
	nextScenePath = path
	get_node("Animation").play("fade")

func change_scene():
	if nextScenePath != null:
		get_tree().change_scene(nextScenePath)

func put_above(path):
	if aboveNode != null:
		return
	get_tree().paused = true
	aboveNode = load(path).instance()
	get_tree().get_root().add_child(aboveNode)

func clear_above():
	if aboveNode == null:
		return
	get_tree().paused = false
	get_tree().get_root().remove_child(aboveNode)
	aboveNode = null
