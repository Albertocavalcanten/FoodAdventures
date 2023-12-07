#Script de funções da Classe Alimento
extends Area2D

var x #coordenada x para posicionamento
var y #coordenada y para posicionamento
var type
var select = false

signal selected(obj, boolean)

func _ready():
	randomize()

func define_type(type):
	self.type = type
	get_node("FoodImage").set_texture(load("res://Assets/Foods/food" + str(type) + ".png"))

func set_data(x, y):
	self.x = x
	self.y = y
	
	"""
	calculo de posicionamento dos elementos na matriz de jogo
	onde 130 representa a posição do canto superior esquerdo da matriz na tela
	110/2 representa o tamanho do elemento Food que compõe a matriz de jogo
	"""
	set_position(Vector2(130 + x * 130 + 110/2, 160 + y * 130 + 110/2))

func _on_Food_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch and event.is_pressed():
		if select:
			get_node("Selection").hide()
			select = false
			emit_signal("selected", self, false)
		else:
			get_node("Selection").show()
			select = true
			emit_signal("selected", self, true)
