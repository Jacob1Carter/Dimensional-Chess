extends Node3D

@export var debug_key : String = "debug_key"

var KingScene = preload("res://Scenes/king.tscn")
var QueenScene = preload("res://Scenes/queen.tscn")
var BishopScene = preload("res://Scenes/Bishop.tscn")
var KnightScene = preload("res://Scenes/knight.tscn")
var RookScene = preload("res://Scenes/rook.tscn")
var PawnScene = preload("res://Scenes/pawn.tscn")

var poslist = {
	# "Node name": [Scene, "Group name", x, y]
	
	# White pieces
	"KingW1": [KingScene, "WhitePieces", -0.5, -3.5],
	"QueenW1": [QueenScene, "WhitePieces", 0.5, -3.5],
	"BishopW1": [BishopScene, "WhitePieces", -1.5, -3.5],
	"BishopW2": [BishopScene, "WhitePieces", 1.5, -3.5],
	"KnightW1": [KnightScene, "WhitePieces", -2.5, -3.5],
	"KnightW2": [KnightScene, "WhitePieces", 2.5, -3.5],
	"RookW1": [RookScene, "WhitePieces", -3.5, -3.5],
	"RookW2": [RookScene, "WhitePieces", 3.5, -3.5],
	"PawnW1": [PawnScene, "WhitePieces", -3.5, -2.5],
	"PawnW2": [PawnScene, "WhitePieces", -2.5, -2.5],
	"PawnW3": [PawnScene, "WhitePieces", -1.5, -2.5],
	"PawnW4": [PawnScene, "WhitePieces", -0.5, -2.5],
	"PawnW5": [PawnScene, "WhitePieces", 0.5, -2.5],
	"PawnW6": [PawnScene, "WhitePieces", 1.5, -2.5],
	"PawnW7": [PawnScene, "WhitePieces", 2.5, -2.5],
	"PawnW8": [PawnScene, "WhitePieces", 3.5, -2.5],
	
	# Black Pieces
	"KingB1": [KingScene, "BlackPieces", -0.5, 3.5],
	"QueenB1": [QueenScene, "BlackPieces", 0.5, 3.5],
	"BishopB1": [BishopScene, "BlackPieces", -1.5, 3.5],
	"BishopB2": [BishopScene, "BlackPieces", 1.5, 3.5],
	"KnightB1": [KnightScene, "BlackPieces", -2.5, 3.5],
	"KnightB2": [KnightScene, "BlackPieces", 2.5, 3.5],
	"RookB1": [RookScene, "BlackPieces", -3.5, 3.5],
	"RookB2": [RookScene, "BlackPieces", 3.5, 3.5],
	"PawnB1": [PawnScene, "BlackPieces", -3.5, 2.5],
	"PawnB2": [PawnScene, "BlackPieces", -2.5, 2.5],
	"PawnB3": [PawnScene, "BlackPieces", -1.5, 2.5],
	"PawnB4": [PawnScene, "BlackPieces", -0.5, 2.5],
	"PawnB5": [PawnScene, "BlackPieces", 0.5, 2.5],
	"PawnB6": [PawnScene, "BlackPieces", 1.5, 2.5],
	"PawnB7": [PawnScene, "BlackPieces", 2.5, 2.5],
	"PawnB8": [PawnScene, "BlackPieces", 3.5, 2.5],
}


func _ready() -> void:
	var tree = get_tree()
	for piece in poslist:
		var scene = poslist[piece][0]
		var group_name = poslist[piece][1]
		var x = poslist[piece][2]
		var y = poslist[piece][3]

		var piece_instance = scene.instantiate()
		piece_instance.name = piece
		piece_instance.position = Vector3(x, 0, y)

		# Use call_deferred to avoid "Parent node is busy" error
		tree.current_scene.call_deferred("add_child", piece_instance)
		piece_instance.add_to_group(group_name)
		piece_instance.add_to_group("Pieces")


# this func JUST moves a piece, it does not check if it is a legal move, that should be checked before this.
func _move(piece, x, z) -> void:
	print_debug("HERE")
	var pieces = get_tree().get_nodes_in_group("Pieces")
	for piece_it in pieces:
		if piece_it != piece and piece_it.transform.x == x and piece_it.transform.z == z:
			# piece is taken (unimplemented)
			piece_it.visable = false
	position = piece.transform.origin
	position.x = x
	position.z = z
	piece.tranform.origin = position


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(debug_key):
		_move(poslist["PawnW3"][0], 0.5, 2.5)
