#Script de funções de gerenciamento dos níveis do jogo
extends Node

const COLUMNS = 8 #8 representa a dimensão de colunas da matriz do jogo
const ROWS = 4 #4 representa a dimensão de linhas da matriz do jogo

onready var bar = get_parent().get_node("Bar")
var rightFoodMatrix = [] #matriz com as repostas do nível
var complementFoodMatrix = [] #matriz complementar do nível
var rightFoodCounter = 0 #contador de respostas certas
var complementFoodCounter = 0 #contador de complementos

var food = preload("res://Scenes/Food.tscn")

var random1 #armazena um número aleatório
var random2 #armazena um número aleatório
var matrix = []
var type = 0 #define o tipo de comida que será instanciado em um elemento da matriz
var complement = false #controlador de permissão de instaciamento de alimentos complementares na matriz

var numberOfSelected = 0
var numberOfAnswers = 0

func _ready():
	randomize()
	read_level()
	objective()

func objective():
	get_node("Control/ControlTimer").start()

func _on_ControlTimer_timeout():
	get_node("Control/ConfirmButton").show()

func _on_ConfirmButton_pressed():
	get_node("Control/ObjectiveTitle").hide()
	get_node("Control/ObjectiveText").hide()
	get_node("Control/ConfirmButton").hide()
	clear_matrix()
	if Transition.soundState == true:
		get_parent().get_node("GameSoundtrack").play()
	answerMatrix()
	complementMatrix()
	bar.connect("lost", self, "lose")

func read_level():
	if Transition.level == null:
		Transition.level = 1
	
	var file = File.new()
	file.open("res://Assets/Levels/level" + str(Transition.level) + ".txt", file.READ)
	var text = file.get_as_text()
	var levelSet = text.split("\n")
	file.close()
	
	get_node("Control/ObjectiveTitle").set_text(levelSet[0])
	get_node("Control/ObjectiveText").set_bbcode(levelSet[1])
	rightFoodMatrix = levelSet[2].split(",")
	complementFoodMatrix = levelSet[3].split(",")
	Transition.content = levelSet[4]

func clear_matrix():
	for x in range(COLUMNS):
		matrix.append([])
		matrix[x] = []
		for y in range(ROWS):
			matrix[x].append([])
			matrix[x][y] = null

func answerMatrix():
	for x in range(COLUMNS):
		for y in range(ROWS):
			random1 = int(rand_range(0, COLUMNS))
			random2 = int(rand_range(0, ROWS))
			complement = false
			if matrix[random1][random2] == null:
				matrix[random1][random2] = gen_food(random1, random2)
			#repetição adicional caso a primeira tentativa resulte em posição inválida na matriz
			else:
				random1 = int(rand_range(0, COLUMNS))
				random2 = int(rand_range(0, ROWS))
				if matrix[random1][random2] == null:
					matrix[random1][random2] = gen_food(random1, random2)

func complementMatrix():
	for x in range(COLUMNS):
		for y in range(ROWS):
			complement = true
			if matrix[x][y] == null:
				matrix[x][y] = gen_food(x, y)

func gen_food(x, y):
	if not complement:
		if rightFoodCounter < rightFoodMatrix.size():
			type = rightFoodMatrix[rightFoodCounter]
			var newFood = food.instance()
			newFood.define_type(type)
			rightFoodCounter += 1
			newFood.set_data(x, y)
			#função check será chamada cada vez que houver uma interação com o alimento
			newFood.connect("selected", self, "check")
			add_child(newFood)
			return newFood
	
	if complement:
		if complementFoodCounter < complementFoodMatrix.size():
			type = complementFoodMatrix[complementFoodCounter]
			var newFood = food.instance()
			newFood.define_type(type)
			complementFoodCounter += 1
			newFood.set_data(x, y)
			#função check será chamada cada vez que houver uma interação com o alimento
			newFood.connect("selected", self, "check")
			add_child(newFood)
			return newFood

func check(obj, boolean):
	if boolean:
		for x in range(rightFoodMatrix.size()):
			if obj.type == rightFoodMatrix[x]:
				numberOfAnswers += 1
		numberOfSelected += 1
	else:
		for x in range(rightFoodMatrix.size()):
			if obj.type == rightFoodMatrix[x]:
				numberOfAnswers -= 1
		numberOfSelected -= 1
	
	win()

func win():
	if numberOfAnswers == rightFoodMatrix.size():
		if numberOfSelected == rightFoodMatrix.size():
			bar.set_process(false)
			Transition.level = Transition.level + 1
			Transition.put_above("res://Scenes/Win.tscn")

func lose():
	bar.set_process(false)
	Transition.put_above("res://Scenes/Lose.tscn")
