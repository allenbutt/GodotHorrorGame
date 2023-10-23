extends CharacterBody3D

@export var playerSpeed = 7.0
@export var playerAcceleration = 5.0
@export var jumpForce = 8.0
@export var gravity = 30.0
@export var cameraSensitivity = 0.25
@export var cameraAcceleration = 7.5
@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var hand = $Hand
@onready var Flashlight = $Hand/Flashlight
@onready var FlashlightSmall = $Hand/FlashlightSmall

var direction = Vector3.ZERO
var head_y_axis = 0.0
var camera_x_axis = 0.0


func _input(event):
	if event is InputEventMouseMotion:
		head_y_axis += event.relative.x * cameraSensitivity
		camera_x_axis += event.relative.y * cameraSensitivity
		camera_x_axis = clamp(camera_x_axis, -90.0, 90.0)

func _process(delta):
	direction = Input.get_axis("left","right") * head.basis.x + Input.get_axis("forward", "backward") * head.basis.z
	velocity = velocity.lerp(direction * playerSpeed + velocity.y * Vector3.UP, playerAcceleration * delta)
	
	hand.rotation.y = lerp(hand.rotation.y, -deg_to_rad(head_y_axis), cameraAcceleration * delta)
	Flashlight.rotation.x = lerp(Flashlight.rotation.x, -deg_to_rad(camera_x_axis), cameraAcceleration * delta)
	FlashlightSmall.rotation.x = lerp(Flashlight.rotation.x, -deg_to_rad(camera_x_axis), cameraAcceleration * delta)
	#FlashlightInverse.rotation.x = lerp(Flashlight.rotation.x, -deg_to_rad(camera_x_axis), cameraAcceleration * delta)
	
	head.rotation.y = -deg_to_rad(head_y_axis)
	camera.rotation.x = -deg_to_rad(camera_x_axis)
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jumpForce
	else:
		velocity.y -= gravity * delta
	
	move_and_slide()
	
	
