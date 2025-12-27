extends RigidBody2D

@export var move_force = 5000.0
@export var jump_force = 500.0
@export var max_speed = 800.0

var screen_size: Vector2

func _ready():
	screen_size = get_viewport_rect().size

	linear_damp = 1.0
	set_linear_damp_mode(DampMode.DAMP_MODE_REPLACE)

	lock_rotation = true

	$CollisionShape2D.disabled = false

func _physics_process(delta):
	var force = Vector2.ZERO

	if Input.is_action_pressed("rightMove"):
		force.x += move_force
	elif Input.is_action_pressed("leftMove"):
		force.x -= move_force

	if Input.is_action_just_pressed("jump"):
		apply_central_impulse(Vector2(0, -jump_force))

	if force != Vector2.ZERO:
		apply_central_force(force)

	if linear_velocity.length() > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed

	position = position.clamp(Vector2.ZERO, screen_size)

	update_animation()

func update_animation():
	if abs(linear_velocity.x) > 10:
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.animation = "rightMove"
		$AnimatedSprite2D.flip_h = linear_velocity.x < 0
	else:
		$AnimatedSprite2D.stop()

func is_on_floor() -> bool:
	return linear_velocity.y == 0 and position.y >= screen_size.y - 50

func start(pos):
	position = pos
	linear_velocity = Vector2.ZERO
	$CollisionShape2D.disabled = false
