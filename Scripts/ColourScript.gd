extends MeshInstance3D

@export var white_material : StandardMaterial3D
@export var black_material : StandardMaterial3D

func _ready() -> void:
	var parent = get_parent()
	if parent.is_in_group("WhitePieces"):
		set_surface_override_material(0, white_material)
	elif parent.is_in_group("BlackPieces"):
		set_surface_override_material(0, black_material)
