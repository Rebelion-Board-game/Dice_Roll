extends RigidBody3D

class_name Dice

signal roll_finished(value)

const ROLL_STRENGHT = 300

@onready var nodes = $Faces.get_children()

var start_pos
var clicked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = global_position
	var parent = get_parent()
	parent.roll.connect(_roll)

func _roll():
	clicked = true
	sleeping = false
	freeze = false
	#transform.origin = start_pos
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	
	# Random rotation
	transform.basis = Basis(Vector3.RIGHT, randf_range(0,2*PI)) * transform.basis
	transform.basis = Basis(Vector3.UP, randf_range(0,2*PI)) * transform.basis
	transform.basis = Basis(Vector3.FORWARD, randf_range(0,2*PI)) * transform.basis
	
	# Random throw impulse
	var throw_vector = Vector3(randf_range(-1,1),0,randf_range(-1,1)).normalized()
	angular_velocity = throw_vector * ROLL_STRENGHT / 2
	apply_central_force(throw_vector * ROLL_STRENGHT)
	
	$Timer.start(6)

func _on_sleeping_state_changed():
	var result = null
	if clicked:
		if sleeping:
			for node in nodes:
				if result == null:
					result = node
				if result.global_transform.origin.y < node.global_transform.origin.y:
					result = node
			emit_signal("roll_finished",int(result.name.replace("D","")))
			clicked = false

func _on_timer_timeout():
	if sleeping == false:
		_roll()
