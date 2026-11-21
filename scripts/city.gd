@tool
extends Node3D

func _ready() -> void:
	build_city()

func build_city() -> void:
	var ground := MeshInstance3D.new()
	var cube := BoxMesh.new()
	cube.size = Vector3(50.0, 1.0, 50.0)
	ground.mesh = cube
	ground.position.y = -0.5
	var grass := StandardMaterial3D.new()
	grass.albedo_color = Color(0.20, 0.45, 0.20)
	cube.material = grass
	add_child(ground)

	for x in range(-12, 13, 3):
		for z in range(-12, 13, 3):
			if abs(x) % 6 == 0 and abs(z) % 6 == 0:
				continue
			create_house(Vector3(x, 0.0, z), Vector3(2.2, 2.5, 2.2))

func create_house(pos: Vector3, size: Vector3) -> void:
	var house := MeshInstance3D.new()
	var box := BoxMesh.new()
	box.size = size
	house.mesh = box
	house.position = pos + Vector3(0.0, size.y / 2.0, 0.0)
	var paint := StandardMaterial3D.new()
	paint.albedo_color = Color(randf_range(0.45, 0.80), randf_range(0.35, 0.65), randf_range(0.25, 0.55))
	box.material = paint
	add_child(house)
