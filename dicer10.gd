extends Node3D

var start_pos
const ROLL_STRENGTH = 0.1
var is_rolling = false
var roll_duration = 15.0  # Czas trwania obrotu kostką (w sekundach)
var roll_timer = 0.0
var result = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = global_transform.origin
	roll_dice()

# Called every frame.
func _process(delta):
	if is_rolling:
		rotate_dice()
		roll_timer += delta
		if roll_timer >= roll_duration:
			is_rolling = false
			result = get_dice_value()
			#emit_signal("roll_finished", result)

# Funkcja do rozpoczęcia obrotu kostką
func roll_dice():
	is_rolling = true
	roll_timer = 0.0

var random_rotation = Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1)).normalized()
# Funkcja do obracania kostką
func rotate_dice():
	rotate_object_local(random_rotation,0.06)

# Funkcja do obliczania wartości kostki (dla przykładu)
func get_dice_value():
	return randi() % 6 + 1
