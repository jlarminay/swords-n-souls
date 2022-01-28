extends KinematicBody2D

var speed = 30;
var max_life = 10;
var cur_life = 0;
var vector;
var target;

func start(pos, spd, vec, tar):
	$shoot.play(0);
	speed = spd;
	global_position = pos;
	vector = vec;
	target = tar;

func _process(delta):
	$Line2D.set_point_position(1, (target-global_position) );
	var collision = move_and_collide(vector * delta * speed);
	
	cur_life += delta;
	if(cur_life > max_life):
		queue_free();

func _on_Area2D_body_entered(body):
	if( body.name=="sword" ):
		body.damage(10, true);
		queue_free();
	elif( body.name == "TileMap" ):
		queue_free();
