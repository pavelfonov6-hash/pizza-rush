extends CharacterBody3D

signal pizza_thrown(position: Vector3, direction: Vector3)

@export var speed := 9.0
@export var turn_speed := 2.2
@export var throw_force := 14.0

@onready var camera_pivot: Node3D = $CameraPivot

var gravity := 20.0

func _physics_process(delta: float) -> void:
	var steering := Input.get_axis("ui_right", "ui_left")
	var throttle := Input.get_axis("ui_down", "ui_up")

	rotate_y(-steering * turn_speed * throttle * delta)
	var forward := -transform.basis.z
	velocity.x = forward.x * throttle * speed
	velocity.z = forward.z * throttle * speed

	if not is_on_floor():
		velocity.y -= gravity * delta

	move_and_slide()

	camera_pivot.global_position = global_position

	if Input.is_action_just_pressed("throw_pizza"):
		throw_pizza()

func throw_pizza() -> void:
	var dir := (-transform.basis.z + Vector3.UP * 0.9).normalized()
	pizza_thrown.emit(global_position + Vector3.UP * 1.4, dir * throw_force)
