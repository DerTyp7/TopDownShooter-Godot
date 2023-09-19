extends CharacterBody2D

var speed: float = 100.0 
var motion: Vector2 = Vector2.ZERO

func _ready():
	pass

func _physics_process(delta):
	var player = get_parent().get_node("Player")
	var direction = (player.position - position).normalized()
	motion = direction * speed
	look_at(player.position)
	
	move_and_collide(motion * delta)


func _on_area_2d_body_entered(body):
	print("Bullet hit")
	print(body.name)
	if "Bullet" in body.name:
		queue_free()
