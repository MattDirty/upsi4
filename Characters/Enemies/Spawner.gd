extends Node2D


@export var character: PackedScene
@export var spawn_rate: float
@export var min_distance: float
@export var max_distance: float
@export var max_units: int
@export var container_name: String

var time_since_last_spawn: float = 0
var total_spawned: int
var container: Node

@onready var Player := $"%Player"


# Called when the node enters the scene tree for the first time.
func _ready():
	container = Node.new()
	container.name = container_name
	add_sibling.call_deferred(container)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if time_since_last_spawn >= spawn_rate:
		for i in time_since_last_spawn / spawn_rate:
			spawnCharacter()
			total_spawned += 1
			if max_units > 0 and total_spawned >= max_units:
				queue_free()
				return
		time_since_last_spawn = 0
	else:
		time_since_last_spawn += delta


func spawnCharacter():
		var spawn_position = Vector2(randf_range(min_distance, max_distance), 0).rotated(randf() * 2.0 * PI)
		var new_character = character.instantiate()
		new_character.name = container_name + "_unit" + str(total_spawned)
		new_character.position = spawn_position + Player.position
		container.add_child(new_character)
