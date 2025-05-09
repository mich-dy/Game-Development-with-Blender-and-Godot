extends CharacterBody3D

@onready var default_3d_map_rid: RID = get_world_3d().get_navigation_map()
@onready var camera: Camera3D = get_viewport().get_camera_3d()
@onready var space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state

var movement_speed: float = 3.0
var movement_delta: float
var path_point_margin: float = 0.5

var current_path_index: int = 0
var current_path_point: Vector3
var current_path: PackedVector3Array

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1:
		find_path(event)

func _physics_process(delta: float) -> void:
	move_along(current_path, delta)

func find_path(event: InputEvent) -> void:
	var params = PhysicsRayQueryParameters3D.new()
	params.from = camera.project_ray_origin(event.position)
	params.to = params.from + camera.project_ray_normal(event.position) * 100
	var result = space_state.intersect_ray(params)

	if result and result.collider:
		var start_position: Vector3 = global_transform.origin
		
		current_path = NavigationServer3D.map_get_path(
		default_3d_map_rid,
		start_position,
		result.position,
		true)
		
		if not current_path.is_empty():
			current_path_index = 0
			current_path_point = current_path[0]

func move_along(path:PackedVector3Array, delta: float) -> void:
	movement_delta = movement_speed * delta

	if global_transform.origin.distance_to(current_path_point) <= path_point_margin:
		current_path_index += 1
		if current_path_index >= current_path.size():
			current_path = []
			current_path_index = 0
			current_path_point = global_transform.origin
			return

	current_path_point = current_path[current_path_index]

	var new_velocity: Vector3 = global_transform.origin.direction_to(current_path_point) * movement_delta
	global_transform.origin = global_transform.origin.move_toward(global_transform.origin + new_velocity, movement_delta)
	look_at(current_path[current_path_index], Vector3.UP)
