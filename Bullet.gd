extends RigidBody2D

var destroy_timer := Timer.new()

func _ready():
	add_child(destroy_timer)
	destroy_timer.wait_time = 5.0
	destroy_timer.one_shot = true  # Automatically stops after timing out
	
	# Start the timer
	destroy_timer.start()
	
	# Connect the "timeout" signal
	destroy_timer.connect("timeout", _on_destroy_timer_timeout)
	
	# Set the wait time for the timer (5 seconds)


	

func _on_destroy_timer_timeout():
	# This function will be called when the timer times out
	queue_free()  # Destroy the object
