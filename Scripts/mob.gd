extends CharacterBody3D

signal squashed

@export var min_speed = 10
@export var max_speed = 18

func _physics_process(_delta: float) -> void:
	move_and_slide()

func initialise(start_position, player_position):
	var target_position = player_position
	target_position.y = start_position.y # this resets the direction of mob to b parallel to ground, in case it spawns when player is mid-jump (so its not looking up)
	
	look_at_from_position(start_position, target_position) # places mob at start_position and rotates it to face direction of player
	rotate_y(randf_range(-PI/4, PI/4)) # random rotation
	
	var random_speed = randi_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y) # rotates along y-axis
	
	$AnimationPlayer.speed_scale = random_speed / min_speed # sets animation speed based on movement speed

func _on_visible_on_screen_enabler_3d_screen_exited() -> void:
	queue_free()

func squash():
	squashed.emit()
	queue_free()
