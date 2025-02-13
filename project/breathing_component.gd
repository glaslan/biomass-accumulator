extends Node

class_name BreathingComponent

@export var mesh_ins: Node3D
@export var min_scale: float = 0.9  # Minimum scale factor
@export var max_scale: float = 1.1  # Maximum scale factor
@export var duration: float = 2.0  # Time to complete one breath cycle

var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_breathing()

func start_breathing():
	tween = mesh_ins.create_tween()
	tween.set_loops()  # Loops forever
	tween.tween_property(mesh_ins, "scale", Vector3(max_scale, max_scale, max_scale), duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(mesh_ins, "scale", Vector3(min_scale, min_scale, min_scale), duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
