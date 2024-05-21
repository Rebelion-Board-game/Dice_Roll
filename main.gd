extends Node3D

signal roll_end(Array) # singal emited when roll of every dice ended
signal roll

@export var D10_number = 10
@export var D6_number = 0
@export var sum = true

var dices = ["D6","D10"]
var dice_number = 0
var D10_instance = preload("res://dices/dice10.tscn")
var D6_instance = preload("res://dices/dice6.tscn")

var result = []
var finished = 0 # store number of dices which finished rolling

var clicked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	## UNCOMMENT IF YOU WANT TO CONECT START_ROLLING SIGNAL FROM PARENT NODE
	#get_parent().start_rolling.connect(start_rolling) 
	
	# add dices
	for dice in dices:
		var scene = get(str(dice) + "_instance")
		dice = get(dice + "_number")
		print(dice)
		for num in dice:
			dice_number += 1
			var instance = scene.instantiate()
			add_child(instance)
			instance.roll_finished.connect(finish_roll)
	print(get_children())

func _input(event):
	if event.is_action_pressed("ui_accept"):
		start_rolling()

func finish_roll(value):
	finished += 1
	if sum:
		if result.size() == 0:
			result.append(value)
		else:
			result[0] += value
	else:
		result.append(value)
		
	# check if every dice finished rolling
	if finished == dice_number:
		clicked = false
		finished = 0
		emit_signal("roll_end",result)
		print(result)
		result = []

func start_rolling():
	if !clicked:
		emit_signal("roll")
