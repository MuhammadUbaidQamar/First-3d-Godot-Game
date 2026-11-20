extends Node

@export var mob_scene: PackedScene

func _ready() -> void:
	$UserInterface/Retry.hide()

func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate() # instatntiates new mob instance
	
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation") # stores reference to SpawnLocation node
	mob_spawn_location.progress_ratio = randf() # gives it a random offset
	
	var player_position = $Player.position # stores the position of the player node
	mob.initialise(mob_spawn_location.position, player_position) # runs the function in mob script giving it required parameters
	
	add_child(mob) # adds child to Main node / spawns
	
	# connect mob to score label to update score when mob gets squashed
	mob.squashed.connect($UserInterface/ScoreLabel._on_mob_squashed.bind())

func _on_player_hit() -> void:
	$MobTimer.stop()
	$UserInterface/Retry.show()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("retry") and $UserInterface/Retry.visible:
		get_tree().reload_current_scene()
