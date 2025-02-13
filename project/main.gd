extends Node

@export var group_name: String = "BioNode"  # Group name to scale
@export var min_scale: float = 0.9  # Minimum scale factor
@export var max_scale: float = 1.1  # Maximum scale factor
@export var duration: float = 2.0  # Time to complete one breath cycle

var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_breathing()

func _on_button_pressed():
	var timer = Timer.new()
	timer.wait_time = 0.1  # Set duration (in seconds)
	timer.one_shot = true  # Timer will stop after one run
	timer.timeout.connect(_on_timer_timeout)  # Connect signal
	add_child(timer)  # Add timer to the scene tree
	timer.start()  # Start the timer

func _on_timer_timeout():
	start_breathing()

func start_breathing():
	for node in get_tree().get_nodes_in_group(group_name):
		if node is Node3D:
			animate_breathing(node)

func animate_breathing(node: Node3D):
	tween = node.create_tween()
	tween.set_loops()  # Loops forever
	tween.tween_property(node, "scale", Vector3(max_scale, max_scale, max_scale), duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(node, "scale", Vector3(min_scale, min_scale, min_scale), duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
