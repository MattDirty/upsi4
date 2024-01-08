extends Node

## The object that should be generated
@export var object_scene: PackedScene
## Target number of objects spawned for each 100x100 square
@export var density: float
## The size in pixels around which other same objects can't spawn
@export var spawn_boundary: int = 0
## The name of the container for the generated objects
@export var nodes_name: String = "Objects"
var container: Node

func _ready():
	container = Node.new()
	container.name = nodes_name
	add_sibling.call_deferred(container)
	generate()

func generate():
	for i in density:
		var new_object = object_scene.instantiate()
		new_object.position = Vector2(randf() * 1000, randf() * 1000)
		new_object.get_node("SpawnBoundary/CollisionShape2D").shape.radius = spawn_boundary
		container.add_child(new_object)
		# need to make use of the spawnboundary... not working as is
		if new_object.get_node("SpawnBoundary").has_overlapping_areas():
			new_object.queue_free()
