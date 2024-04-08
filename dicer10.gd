extends RigidBody3D

var start_pos
const ROLL_STRENGHT = 200

@onready var ray_casts = $Node3D.get_children()

signal roll_finished(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = global_position
	

func _input(event):
	if event.is_action_pressed("ui_accept"):
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
	if sleeping:
		for ray in ray_casts:
			if ray.is_colliding():
				if ray.name == "D1":
					result = 8
				if ray.name == "D2":
					result = 3
				if ray.name == "D3":
					result = 6
				if ray.name == "D4":
					result = 5
				if ray.name == "D5":
					result = 4
				if ray.name == "D6":
					result = 1
				if ray.name == "D7":
					result = 2
				if ray.name == "D8":
					result = 7
				if ray.name == "D9":
					result = 10
				if ray.name == "D10":
					result = 9
	print(result)
#func _process(delta):
	#print($Node3D/D2.get_collider())
