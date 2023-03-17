extends KinematicBody2D

var velocity = Vector2()
var current_state := 2

enum { JUMP, WALK , FALL, IDLE }
var enter_state := true

func _physics_process(delta):
	match current_state:
		WALK:
			_walk_state(delta)
		JUMP:
			_jump_state(delta)
		IDLE:
			_idle_state(delta)
		FALL:
			_fall_state(delta)
# state functions
func _fall_state(_delta):
	_apply_gravity(_delta)
	_move()
	_move_and_slide()
	_set_state(_check_fall_state())
	
func _jump_state(_delta):
	if enter_state:
		velocity.y = -400
		enter_state = false
	_apply_gravity(_delta)
	_move()
	_move_and_slide()
	_set_state(_check_jump_state())
	
func _walk_state(_delta):
	_move()
	_apply_gravity(_delta)
	_move_and_slide()
	_set_state(_check_walk_state())
	
func _idle_state(_delta):
	_apply_gravity(_delta)
	velocity.x = 0
	_move_and_slide()
	_set_state(_check_idle_state())
	
func _check_idle_state():
	var new_state = current_state
	
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		new_state = WALK
		
	elif Input.is_action_just_pressed("ui_up"):
		new_state = JUMP
		
	elif not is_on_floor():
		new_state = FALL
		
	return new_state
	
func _check_walk_state():
	var new_state = current_state
	if (not Input.is_action_pressed("ui_left")) and (not Input.is_action_pressed("ui_right")):
		new_state = IDLE
		
	elif Input.is_action_just_pressed("ui_up"):
		new_state = JUMP
		
	elif not is_on_floor():
		new_state = FALL
		
	return new_state

func _check_jump_state():
	var new_state = current_state
	if velocity.y >= 0:
		new_state = FALL
		
	return new_state
	
func _check_fall_state():
	var new_state = current_state
	if is_on_floor():
		new_state = IDLE
		
	return new_state
# helpers
func _apply_gravity(_delta):
	velocity.y += 800 * _delta
	
func _move_and_slide():
	velocity = move_and_slide(velocity, Vector2.UP)
	
func _move():
	if Input.is_action_pressed("ui_left"):
		velocity.x = -120
		$Sprite.flip_h = true
		
	if Input.is_action_pressed("ui_right"):
		velocity.x = 120
		$Sprite.flip_h = false
		
func _set_state(new_state):
	if new_state != current_state:
		enter_state = true
		
	current_state = new_state
# other functions
#func _get_coin():
#	Global.coins += 1
