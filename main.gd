extends Node3D

const PIZZA_SCENE := preload("res://pizza.tscn")

var score := 0
var time_left := 60.0

func _ready() -> void:
	$Player.pizza_thrown.connect(_on_pizza_thrown)

func _process(delta: float) -> void:
	time_left -= delta
	if time_left < 0:
		time_left = 0
	$CanvasLayer/HUD/TimeLabel.text = "Time: %.1f" % time_left
	$CanvasLayer/HUD/ScoreLabel.text = "Score: %d" % score

	if time_left == 0:
		get_tree().paused = true

func _on_pizza_thrown(pos: Vector3, velocity: Vector3) -> void:
	var pizza := PIZZA_SCENE.instantiate()
	add_child(pizza)
	pizza.global_position = pos
	pizza.linear_velocity = velocity
	pizza.angular_velocity = Vector3(randf_range(-8, 8), randf_range(-8, 8), randf_range(-8, 8))

	var tween := create_tween()
	tween.tween_property($Player, "rotation:y", $Player.rotation.y + 0.35, 0.12)
	tween.tween_property($Player, "rotation:y", $Player.rotation.y, 0.25)
