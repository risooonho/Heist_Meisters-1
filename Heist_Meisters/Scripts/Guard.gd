extends "res://Scripts/PlayerDetection.gd"

var motion = Vector2()
var possible_navpoints = []
var path_ = []
var destination = Vector2()

export var walk_slowdown = 0.5
export var nav_stop_threshold = 5 # Gives 5 pixel margin of error to stop movement

onready var navigation = Global.navigation
onready var available_navpoints = Global.navpoints


func _ready():
	possible_navpoints = available_navpoints.get_children()
	make_path()


func _process(delta):
	navigate()


func navigate():
	var distance_to_navpoint = position.distance_to(path_[0])
	destination = path_[0]
	
	if distance_to_navpoint > nav_stop_threshold:
		move()
	else:
		update_path()


func move():
	look_at(destination)
	motion = (destination - position).normalized() * (MAX_SPEED * walk_slowdown)
	
	if is_on_wall():
		make_path()
	
	move_and_slide(motion)


func make_path():
	randomize()
	var next_navpoint = possible_navpoints[randi() % possible_navpoints.size()]
	
	path_ = navigation.get_simple_path(global_position, next_navpoint.global_position, false)


func update_path():
	if path_.size() == 1:
		if $Timer.is_stopped():
			$Timer.start()
	else:
		path_.remove(0)


func _on_Timer_timeout():
	make_path()

