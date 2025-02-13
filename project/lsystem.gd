extends Node3D

# Lindenmayer System Rules
class_name LindenmayerSystem

@export var axiom = "NLN"
var rules = {
	"N" : "N[+[][N-N]-[-N]", #Node
	"L" : "+L[N-L]+L[-L]", #Leaf
	"F" : "F", #Fruit/Flower
	"T" : "T" #Tip
}
@export var iterations = 3
# How far the turtle should move each time a node is placed
var turtle_step = 0.3


var plant_scene = preload("res://bio_node.tscn")

func generate_lindenmayer_sequence():
	var current_sequence = axiom
	for i in range(iterations):
		var next_sequence = ""
		for c in current_sequence:
			if rules.has(c):
				next_sequence += rules[c]
			else:
				next_sequence += c
		current_sequence = next_sequence
	return current_sequence

func generate_plant():

	# Reset the transform stack for the turtle
	var transform_stack = []
	var current_transform = Transform3D()
	var sequence = generate_lindenmayer_sequence()

	for c in sequence:
		var angle = randi_range(-160, 160)
		match c:
			"N":
				# Create a new plant stem node
				var plant_node = plant_scene.instantiate()
				plant_node.transform = current_transform
				add_child(plant_node)

				# Move the turtle forward
				current_transform.origin += current_transform.basis.y * turtle_step
			"L":
				# Create a new plant stem with leaf node
				var plant_node = plant_scene.instantiate()
				# Rotating a bit to randomize leaf placement
				plant_node.transform = current_transform.rotated_local(Vector3(0, 1, 0), deg_to_rad(randi_range(-180, 180)))
				add_child(plant_node)
				# Move the turtle forward
				current_transform.origin += current_transform.basis.y * turtle_step	
			"T":
				# Create a new plant stem with leaf node
				var plant_node = plant_scene.instantiate()
				# Rotating a bit to randomize leaf placement
				plant_node.transform = current_transform.rotated_local(Vector3(0, 1, 0), deg_to_rad(randi_range(-180, 180)))
				add_child(plant_node)
				# Move the turtle forward
				current_transform.origin += current_transform.basis.y * turtle_step
			"F": # Not yet implemented
				# Create a new fruit/flower
				var plant_node = plant_scene.instantiate()
				# Rotating a bit to randomize leaf placement
				plant_node.transform = current_transform.rotated_local(Vector3(0, 1, 0), deg_to_rad(randi_range(-180, 180)))
				add_child(plant_node)
				# Move the turtle forward
				current_transform.origin += current_transform.basis.y * turtle_step
			"+":
				# Rotate turtle about z axis
				
				current_transform = current_transform.rotated_local(Vector3(0, 0, 1), deg_to_rad(angle))
			"-":
				# Rotate turtle about x axis
				current_transform = current_transform.rotated_local(Vector3(1, 0, 0), deg_to_rad(angle))
			"[":
				# Push the current transform onto the stack
				transform_stack.append(current_transform)
			"]":
				# Pop the last transform off the stack
				if transform_stack.size() > 0:
					current_transform = transform_stack.pop_back()

func _ready():
	if plant_scene:
		generate_plant()
	else:
		print("Plant scene not found! Check the path.")


func _on_button_pressed() -> void:
	generate_plant()
