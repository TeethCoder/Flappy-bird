extends CharacterBody2D
class_name Player


const JUMP_VELOCITY : float = -300


func _ready() -> void:
	set_physics_process(false)


func _physics_process(delta: float) -> void:
	if is_on_floor():
		get_tree().paused = true

	rotate_the_player(delta)
	apply_gravity(delta)
	jump()
	move_and_slide()


func apply_gravity(delta : float):
	if not is_on_floor():
		velocity += get_gravity() * delta


func jump():
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY


func rotate_the_player(delta : float):
	rotation_degrees = clamp(rotation_degrees, -20, 20)
	rotation_degrees += velocity.y * delta


func enable_physics():
	set_physics_process(true)
