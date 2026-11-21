@tool
extends Node

@export var city_size := 12
@export var road_width := 5.0

func _ready() -> void:
	build_city()

func build_city() -> void:
	var ground := StaticBody3D.new()
	var ground_shape := CollisionShape3D.new()
	var ground_box := BoxShape3D.new()
	ground_box.size = Vector3(50, 1, 50)
	ground_shape.shape = ground_box
	ground.position.y = -0.5
	ground.add_child(ground_shape)
	add_child(ground)

	var ground_mesh := MeshInstance3D.new()
	var cube := BoxMesh.new()
	cube.size = Vector3(50, 1, 50)
	ground_mesh.mesh = cube
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.20, 0.45, 0.20)
	cube.material = material
	ground_mesh.position.y = -0.5
	add_child(ground_mesh)

	for x in range(-city_size, city_size + 1, 3):
		for z in range(-city_size, city_size + 1, 3):
			if abs(x) % 6 == 0 and abs(z) % 6 == 0:
				continue
			create_house(Vector3(x, 0, z), Vector3(2.2, 2.5, 2.2))

	create_delivery_zone(Vector3(7, 0.25, 7))

func create_house(pos: Vector3, size: Vector3) -> void:
	var house := MeshInstance3D.new()
	var box := BoxMesh.new()
	box.size = size
	house.mesh = box
	house.position = pos + Vector3(0, size.y / 2, 0)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(randf_range(0.45, 0.8), randf_range(0.35, 0.65), randf_range(0.25, 0.55))
	box.material = material
	add_child(house)

func create_delivery_zone(pos: Vector3) -> void:
	var zone := MeshInstance3D.new()
	var cylinder := CylinderMesh.new()
	cylinder.top_radius = 1.4
	cylinder.bottom_radius = 1.4
	cylinder.height = 0.08
	zone.mesh = cylinder
	zone.position = pos
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.1, 0.8, 1.0, 0.8)
	cylinder.material = material
	zone.name = "DeliveryZone"
	add_child(zone)
