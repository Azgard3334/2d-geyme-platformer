extends RigidBody2D

var thrust = Vector2(0, -250)
var torque = 20000

func _integrate_forces(state):
	if Input.is_action_pressed("jump"):
		state.apply_force(thrust.rotated(rotation))
	else:
		state.apply_force(Vector2())
	var rotation_direction = 0
	if Input.is_action_pressed("rightMove"):
		rotation_direction += 1
	if Input.is_action_pressed("leftMove"):
		rotation_direction -= 1
	state.apply_torque(rotation_direction * torque)
