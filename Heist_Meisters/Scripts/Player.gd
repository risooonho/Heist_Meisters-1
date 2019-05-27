extends "res://Scripts/Character.gd"

var motion = Vector2()
var vision_change_on_cooldown = false

enum VISION_MODES {DARK, NIGHTVISION}

var vision_mode = VISION_MODES.DARK

func _ready():
	Global.Player = self
	vision_mode = VISION_MODES.DARK


func _process(delta):
	update_motion(delta)
	move_and_slide(motion)


func update_motion(delta):
	look_at(get_global_mouse_position())
	
	# Movement with Normalized Vector2 - code by Udemy user "Jean-François"
	var velocity = Vector2()
	velocity.x += int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	velocity.y += int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	velocity = velocity.normalized() * SPEED
	
	if !(velocity) == Vector2():
		motion += velocity
		motion = motion.clamped(MAX_SPEED)
	else:
		motion.x = lerp(motion.x, 0, FRICTION)
		motion.y = lerp(motion.y, 0, FRICTION)


func _input(event):
	if Input.is_action_just_pressed("ui_vision_mode_change") and not vision_change_on_cooldown:
		cycle_vision_mode()
		vision_change_on_cooldown = true
		$VisionModeTimer.start()


func cycle_vision_mode():
	if vision_mode == VISION_MODES.DARK:
		get_tree().call_group("interface", "NightVision_mode")
		vision_mode = VISION_MODES.NIGHTVISION
	elif vision_mode == VISION_MODES.NIGHTVISION:
		get_tree().call_group("interface", "DarkVision_mode")
		vision_mode = VISION_MODES.DARK


func _on_VisionModeTimer_timeout():
	vision_change_on_cooldown = false


