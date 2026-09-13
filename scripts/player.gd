extends CharacterBody2D

var movement_length = 0
var in_bubble = 0
var start_location: Vector2

func _enter_tree() -> void:
	start_location = global_position
	

func _physics_process(delta: float) -> void:
	var delta_vector = Vector2(Input.get_last_mouse_velocity().x, Input.get_last_mouse_velocity().y)
	var new_scale: Vector2
	new_scale.x = 0.4 - velocity.normalized().y * 0.1
	new_scale.y = 0.4 - velocity.normalized().x * 0.1
	$Head.scale =  $Head.scale.slerp( new_scale, 0.5)
	
	for i in range(get_slide_collision_count()):
		var collison = get_slide_collision(i).get_collider() as RigidBody2D
		if collison is RigidBody2D:
			collison.apply_impulse(velocity*-0.01, collison.to_local(global_position))
			collison.collision_layer = 1
			collison.collision_mask = 1
			$Camera2D/Youwin.show()
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && in_bubble != 0:
		velocity = velocity.move_toward(delta_vector, movement_length)
		movement_length += delta_vector.length() * 0.1
		movement_length *= 0.99
	else:
		velocity.y += 5
	
	# this is how it works in real life
	if is_on_floor():
		velocity *= 0.92
	else:
		velocity *= 0.99
	
	if global_position.y > 580:
		global_position = start_location
		velocity = Vector2.ZERO

	move_and_slide()
	

func entered_bubble():
	in_bubble += 1

func exited_bubble():
	in_bubble -= 1
