extends "res://Scripts/Character.gd"

const FOV_TOLERANCE = 20
const RED = Color(1,.15,.15)
const WHITE = Color(1,1,1)

onready var Player = get_node("/root/Level1/Player") #Make this level neutral

func _process(delta):
	if Player_is_in_FOV_TOLERANCE():
		$Torch.color = RED #Function returns True
	else:
		$Torch.color = WHITE #Function returns False

func Player_is_in_FOV_TOLERANCE():
	var NPC_facing_dir = Vector2(1,0).rotated(global_rotation)
	var direction_to_Player = (Player.position - global_position).normalized()
	
	if abs(direction_to_Player.angle_to(NPC_facing_dir)) < deg2rad(FOV_TOLERANCE):
		return true
	else:
		return false
