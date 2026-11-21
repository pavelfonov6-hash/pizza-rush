extends CharacterBody3D

signal pizza_thrown(position: Vector3, direction: Vector3)

@export var speed: float = 9.0
@export var turn_speed: float = 2.2

func _physics_process(delta: float) -> void:
	var steering: float = Input.get_axis("ui_right", "ui_left")
	var throttle: float = Input.get_axis("ui_down", "ui_up")

	if abs(throttle) > 0.05:
		rotate_y(-steering * turn_speed * throttle * delta)

	var forward: Vector3 = -transform.basis.z
	velocity.x = forward.x * throttle * speed
	velocity.z = forward.z * throttle * speed

	if not is_on_floor():
		velocity.y -= 20.0 * delta

	move_and_slide()

	if Input.is_action_just_pressed("throw_pizza"):
		throw_pizza()

func throw_pizza() -> void:
	var direction: Vector3 = (-transform.basis.z + Vector3.UP * 0.8).normalized()
	pizza_thrown.emit(global_position + Vector3.UP * 1.4, direction * 14.0)
