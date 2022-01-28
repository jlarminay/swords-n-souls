extends Node2D

func _process(delta):
	global_position = get_global_mouse_position();

func _play():
	pass;
	#$counter.visible = true;
	#$counter.set_frame(0);
	#$counter.play("default");

func _on_counter_animation_finished():
	pass;
	#$counter.visible = false;
