extends Node3D

const PIZZA_SCENE := preload("res://pizza.tscn")

var score := 0
var time_left := 60.0

@onready var time_label: Label = $CanvasLayer/HUD/TimeLabel
@onready var score_label: Label = $CanvasLayer/HUD/ScoreLabel

func _ready() -> void:
	$Player.pizza_thrown.connect(_on_pizza_thrown)

func _process(delta: float) -> void:
	time_left = maxf(time_left - delta, 0.0)
	time_label.text = "Time: %.1f" % time_left
	score_label.text = "Score: %d" % score

	if time_left == 0.0:
		get_tree().paused = true

func _on_pizza_thrown(pos: Vector3, direction: Vector3) -> void:
	var pizza := PIZZA_SCENE.instantiate()
	add_child(pizza)
	pizza.global_position = pos
	pizza.linear_velocity = direction
	pizza.angular_velocity = Vector3(randf_range(-8.0, 8.0), randf_range(-8.0, 8.0), randf_range(-8.0, 8.0))
