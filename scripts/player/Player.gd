extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var gravity = 300
var playerVelocity = Vector2.ZERO # Vector2(0,0)
var playerMaxHorizentalSpeed = 110
var playerMaxJumpSpeed = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	playerVelocity.y += gravity * delta
	
	playerVelocity.x = move().x * playerMaxHorizentalSpeed
	
	if (jump().y < 0 && is_on_floor()):
		playerVelocity.y = jump().y * playerMaxJumpSpeed
		
	playerVelocity = move_and_slide(playerVelocity , Vector2.UP)
	
func move():
	var moveVector = Vector2.ZERO
	moveVector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	return moveVector
	
func jump():
	var moveVector = Vector2.ZERO
	moveVector.y = -1 if Input.is_action_just_pressed("jump") else 0
	return moveVector

