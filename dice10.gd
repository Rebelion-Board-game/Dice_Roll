extends RigidBody3D

const ROLL_STRENGHT = 200

var start_pos
var clicked = false
@onready var nodes = $Faces.get_children()

signal roll_finished(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = global_position

func _input(event):
	if event.is_action_pressed("ui_accept"):
		clicked = true
		_roll()
		
func _roll():
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


func _on_sleeping_state_changed():
	var result = null
	if clicked:
		if sleeping:
			for node in nodes:
				if result == null:
					result = node
				if result.global_transform.origin.y < node.global_transform.origin.y:
					result = node
		print(result.name)
