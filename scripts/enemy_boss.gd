extends KinematicBody2D

onready var PARTICLES = $particles;
onready var SPRITE = $Sprite;
onready var LINE = $Line2D;

onready var BUBBLE = $bubble;
var bubble_see = preload("res://sprites/bubble_caught.png");

var bullet = preload("res://objects/bullet.tscn");

export(NodePath) var target_path;
export(int) var detection;

var speed = 50;
var dead = false;
var target;
var tmp_target;
var walking_time = 0;
var dis = 0;
var health = 10;
var velocity = Vector2();

var seen = false;
var bubble_visible = false;
var can_see = false;
var timer = 0;
var timer_limit = 0.5;

var left_alive = 0;

var particles_time;

var shooting = 0.5;

func _ready():
	target = get_node(target_path);
	particles_time = PARTICLES.lifetime*PARTICLES.speed_scale;

func _process(delta):
	
	if(dead):
		calculate_death(delta);
	
	timer += delta;
	if(timer>=timer_limit):
		BUBBLE.visible = false;
		can_see = false;
	
	dis = position.distance_to(target.position);
	if( dis < detection || seen ):
		if(!seen):
			Music._play("boss");
		seen = true;
		speed = 5;
		if(!can_see && !bubble_visible):
			bubble_visible = true;
			can_see = true;
			BUBBLE.texture = bubble_see;
			BUBBLE.visible = true;
			timer = 0;
		var x = position.x - target.position.x;
		if(x>0):
			SPRITE.flip_h = false;
		else:
			SPRITE.flip_h = true;
		
		shooting -= delta;
		if( shooting <= 0 && !dead ):
			shoot();
			shooting = 4;
		
		LINE.set_point_position(1,target.global_position-global_position);
		velocity = position.direction_to(target.position) * speed;
		velocity = move_and_slide(velocity);
	else:
		speed = 3;
		random_point(delta);
		if( tmp_target ):
			LINE.set_point_position(1,tmp_target-global_position);
			velocity = position.direction_to(tmp_target) * speed;
			velocity = move_and_slide(velocity);
			if( position.distance_to(tmp_target) < 1 ):
				tmp_target = null;
		bubble_visible = false;

func calculate_death(delta):
	speed = 0;
	PARTICLES.emitting = true;
	SPRITE.visible = false;
	$collision_area.set_collision_layer_bit(2, false);
	$collision_area.set_collision_mask_bit(0, false);
	particles_time -= delta;
	if(particles_time<=0):
		#print('deleted');
		queue_free();

func damage():
	health -= 1;
	if( health <= 0 ):
		Music._play("victory");
		$die.play();
		Global.kills += 1;
		Global.kills_boss += 1;
		dead = true;
	else:
		$hit.play(0);

func shoot():
	var b1 = bullet.instance();
	var b2 = bullet.instance();
	var b3 = bullet.instance();
	var b4 = bullet.instance();
	var b5 = bullet.instance();
	b1.start(global_position, 75, position.direction_to(target.position), target.global_position );
	b2.start(global_position, 70, position.direction_to(target.position), target.global_position );
	b3.start(global_position, 65, position.direction_to(target.position), target.global_position );
	b4.start(global_position, 60, position.direction_to(target.position), target.global_position );
	b5.start(global_position, 55, position.direction_to(target.position), target.global_position );
	get_parent().add_child(b1);
	get_parent().add_child(b2);
	get_parent().add_child(b3);
	get_parent().add_child(b4);
	get_parent().add_child(b5);

func random_point(delta):
	walking_time -= delta;
	if(walking_time <= 0):
		walking_time = rand_range(3,5);
		tmp_target = position + Vector2(rand_range(-100,100),rand_range(-100,100));

func _on_collision_area_body_entered(body):
	#print( body.name );
	if( body.name == "sword" ):
		body.damage(20);
		damage();
