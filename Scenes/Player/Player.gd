extends CharacterBody2D

const SPEED = 130
const JUMP_VELOCITY = -200.0

var max_health = 80.0
var health = 80.0

var dead = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# If you are dead, don't do anything below
	if dead:
		return
	
	# Add the gravity.

	velocity.y += gravity * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		$AnimatedSprite2D.play("Run")
		velocity.x = direction * SPEED
	else:
		$AnimatedSprite2D.play("Idle")		
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Flip character if moving left
	if direction < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

	move_and_slide()

# Above this is just movement logic, animation logic, and variables for the player

func hurt(damage):
	health -= damage
	
	if health <= 0:
		dead = true
		$AnimatedSprite2D.play("Die")
