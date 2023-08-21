extends KinematicBody2D

var gravity = 1000
var velocity = Vector2.ZERO # Vector2(0,0)
var maxHorizontalSpeed = 140
var jumpSpeed = 340
var horizontalAcceleration = 2000 
var jumpTerminationMultiplier =  4
var maxDashSpeed = 500
var minDashSpeed = 200
var hasDoubleJump = false
var hasDash = false
#var currentState = State.NORMAL
var isStateNew = true
var isDying = false



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var moveVector = setInitialmoveVector()
	
	velocity.x += moveVector.x * horizontalAcceleration * delta
	if (moveVector.x == 0):
		velocity.x = lerp(0, velocity.x, pow(2, -50 * delta))
		
	velocity.x += moveVector.x * horizontalAcceleration * delta
	
	# if we dont have any input in x , we gonna decelarate
	if(velocity.x == 0):
		# velocity.x = lerp(velocity.x , 0 , 0.1)
		velocity.x = lerp( 0 , velocity.x , pow(2 , -50 * delta)) # frame rate independent lerp
	
	# this is gonna prevent us to go above speed limit 
	velocity.x = clamp(velocity.x , -maxHorizontalSpeed , maxHorizontalSpeed)
	
	if (moveVector.y < 0 && is_on_floor()):
		velocity.y = moveVector.y * jumpSpeed
		
	if (velocity.y < 0 && !Input.is_action_pressed("jump")):
		velocity.y += gravity * jumpTerminationMultiplier * delta
	else:
		velocity.y += gravity * delta
		
	velocity = move_and_slide(velocity, Vector2.UP)
	
func setInitialmoveVector():
	var moveVector = Vector2.ZERO
	moveVector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	moveVector.y = -1 if Input.is_action_just_pressed("jump") else 0
	return moveVector
