extends CanvasModulate

const DARK = Color("0c134f")
const NIGHTVISION = Color("0e6f4a")

func _ready():
	add_to_group("interface")
	color = DARK


func NightVision_mode():
	inform_npcs("nightvision_mode")
	color = NIGHTVISION
	$AudioStreamPlayer.stream = load(Global.nightvision_on_sfx)
	play_sfx()


func DarkVision_mode():
	inform_npcs("darkvision_mode")	
	color = DARK
	$AudioStreamPlayer.stream = load(Global.nightvision_off_sfx)
	play_sfx()


func play_sfx():
	$AudioStreamPlayer.play()


func inform_npcs(vision_mode):
	get_tree().call_group("npc", vision_mode)


