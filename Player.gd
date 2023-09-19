extends CharacterBody2D

var movespeed = 300;
var bullet_speed = 2000;
var bullet = preload("res://Bullet.tscn")

var shoot_timer := Timer.new()
var can_shoot := true

func _ready():
	add_child(shoot_timer);
	shoot_timer.wait_time = 0.3
	shoot_timer.start()
	shoot_timer.connect("timeout", _on_shoot_timer_timeout)
	
func _on_shoot_timer_timeout():
	can_shoot = true


func _physics_process(delta):
	look()
	move(delta)
		
#	if Input.is_action_pressed("shoot"):
#		shoot()

func shoot():
	if can_shoot:
		fire()
		can_shoot = false
		shoot_timer.start()
	
func look():
	var look_direction = Vector2.ZERO

	if Input.is_action_pressed("look_up"):
		look_direction.y -= 1
	if Input.is_action_pressed("look_down"):
		look_direction.y += 1
	if Input.is_action_pressed("look_left"):
		look_direction.x -= 1
	if Input.is_action_pressed("look_right"):
		look_direction.x += 1
			
	
	# Diagonal look
	if Input.is_action_pressed("look_up") && Input.is_action_pressed("look_left"):
		look_direction = Vector2(-1, -1).normalized()
	if Input.is_action_pressed("look_up") && Input.is_action_pressed("look_right"):
		look_direction = Vector2(1, -1).normalized()
	if Input.is_action_pressed("look_down") && Input.is_action_pressed("look_left"):
		look_direction = Vector2(-1, 1).normalized()
	if Input.is_action_pressed("look_down") && Input.is_action_pressed("look_right"):
		look_direction = Vector2(1, 1).normalized()

	if look_direction != Vector2.ZERO:
		look_direction = look_direction.normalized()
		rotation = look_direction.angle()
	
	if Input.is_action_pressed("look_up") || Input.is_action_pressed("look_down") || Input.is_action_pressed("look_left") || Input.is_action_pressed("look_right"):
		shoot();	
		
func move(delta):
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("walk_up"):
		velocity.y -= 1
	if Input.is_action_pressed("walk_down"):
		velocity.y += 1
	if Input.is_action_pressed("walk_left"):
		velocity.x -= 1
	if Input.is_action_pressed("walk_right"):
		velocity.x += 1
	
	velocity = velocity.normalized() * movespeed
	
	move_and_slide()
	velocity.lerp(Vector2.ZERO, 0.1)
		
func fire():
	var bullet_instance = bullet.instantiate()  # Create an instance of the bullet
	var offset = Vector2(20, 0).rotated(rotation)  # Adjust the offset as needed
	bullet_instance.position = global_position + offset
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.name = "Bullet " + str(randf())
	# Calculate the bullet direction based on the player's rotation
	var bullet_direction = Vector2(bullet_speed, 0).rotated(rotation)
	
	# Apply the impulse in the correct direction
	bullet_instance.apply_impulse(bullet_direction, Vector2())
	
	# Add the bullet to the scene
	get_tree().get_root().call_deferred("add_child", bullet_instance)


func kill():
	print("kill")
	get_tree().reload_current_scene()


func _on_area_2d_body_entered(body):
	if "Enemy" in body.name:
		kill()
