extends CharacterBody2D

var speed: float = 100.0 
var motion: Vector2 = Vector2.ZERO

func _ready():
	set_meta("dead", false)
	pass

func _physics_process(delta):
	var player = get_parent().get_node("Player")
	var direction = (player.position - position).normalized()
	motion = direction * speed
	look_at(player.position)

	move_and_collide(motion * delta)


#func _on_area_2d_body_entered(body):
#	print("Bullet hit")
#	print(body.name)
#	if "Bullet" in body.name:
#		set_meta("dead", true)
#		queue_free()


func _on_area_2d_area_entered(area):
	print("Bullet hit")
	print(area.get_parent().name)
	if "Bullet" in area.get_parent().name:
		set_meta("dead", true)
		area.get_parent().queue_free()
		queue_free()
