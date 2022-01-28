extends Area2D

func _on_fire_body_entered(body):
	if( body.name=="sword" ):
		body.healed();
		queue_free();
