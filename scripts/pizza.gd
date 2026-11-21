extends RigidBody3D

var life_time := 4.0

func _ready() -> void:
	linear_damp = 0.05
	angular_damp = 0.02

func _physics_process(delta: float) -> void:
	life_time -= delta
	if life_time <= 0:
		queue_free()
