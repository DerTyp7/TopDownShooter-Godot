extends RigidBody2D

var destroy_timer := Timer.new()

func _ready():
	add_child(destroy_timer)
	destroy_timer.wait_time = 5.0
	destroy_timer.one_shot = true
	destroy_timer.start()
	destroy_timer.connect("timeout", _on_destroy_timer_timeout)
	
func _on_destroy_timer_timeout():
	queue_free()
