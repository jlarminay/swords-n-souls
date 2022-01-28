extends KinematicBody2D

onready var SPRITES = $sprites;
onready var COLLIDER = $collider;
onready var SPRITE_SWORD = $sprites/sprite;
onready var SPRITE_SHAD = $sprites/shadow;
onready var LINE = $Line2D;

export(NodePath) var tilemap_path;
export(float) var speed = 200;

var tilemap;
var slide = 0.05;
var is_dead = false;
var has_control = false;
var is_moving = false;
var target = null;
var velocity = Vector2();
var touching_wall = false;

var fly_time = 0;

var max_dis = 0;
var cur_dis = 0;
var cur_hi = 0;

var li_org = 0.8;
var li_cur = 0;
var li_dir = -1;

func _ready():
	tilemap = get_node(tilemap_path);

func _physics_process(delta):
	
	#update light
	if(!is_dead):
		li_cur += 0.2 * delta * li_dir;
		if(abs(li_cur)>0.2):
			li_dir *= -1;
		$Light2D.energy = li_org + li_cur;
	
	if(!is_moving):
		if(Global.click_timer!=100):
			Global._click_count(delta);
	
	damage(0);
	check_input();
	
	if(is_dead):
		if( $Light2D.energy >= 0 ):
			$Light2D.energy -= (delta/4);
	
	if( target!=null ):
		
		cur_dis = global_position.distance_to(target);
		
		if(max_dis==0):
			max_dis = cur_dis;
		
		var per = cur_dis/max_dis * 100;
		
		if(per>50):
			cur_hi += 8*delta;
		else:
			cur_hi -= 8*delta;
		
		SPRITE_SHAD.position = Vector2(cur_hi,0);
		LINE.set_point_position(1, target-global_position );
		var deg = rad2deg(position.angle_to_point(target));
		SPRITE_SWORD.set_rotation_degrees( deg + 180 );
		SPRITE_SHAD.set_rotation_degrees( deg + 180 );
		
		velocity = position.direction_to(target) * speed;
	
		if( position.distance_to(target) > 5 ):
			if(!is_moving):
				$throw.play(0);
			is_moving = true;
			fly_time += delta;
			$move_particles.emitting = true;
			if(fly_time>3):
				fly_time = 0;
				is_moving = false;
				target = null;
				max_dis = 0;
				cur_hi = 0;
				$move_particles.emitting = false;
		else:
			fly_time = 0;
			is_moving = false;
			target = null;
			max_dis = 0;
			cur_hi = 0;
			$move_particles.emitting = false;
		
	velocity = move_and_slide(velocity);
	velocity.x = lerp(velocity.x, 0, slide);
	velocity.y = lerp(velocity.y, 0, slide);

func check_input():
	if( has_control ):
		if( Input.is_action_pressed('click') ):
			if( Global.click_timer==100 ):
				var cursor = get_global_mouse_position();
				var tile_pos = tilemap.world_to_map( cursor );
				var tile_point = tilemap.get_cellv(tile_pos);
				#print( tile_point );
				
				if( tile_point == 5 ):
					Global.click_timer = 0;
					target = cursor;

func damage(val, move=false):
	if( (!is_moving || move) && !is_dead ):
		if(val>0):
			$hit.play(0);
			screen_shake(0.5);
			Global.health -= val;
		if( Global.health <= 0 ):
			$die.play(0);
			is_dead = true;
			has_control = false;

func healed():
	#print('I HAVE BEEN HEALED');
	Global.health += Global.max_health/3;

func finished(target_pos):
	if( has_control ):
		Global.finished = true;
		slide = 1;
		speed = speed / 4;
		has_control = false;
		target = target_pos + Vector2(0,70);

func screen_shake(trauma):
	$Camera2D.add_trauma(trauma);

func _on_wall_collider_body_entered(body):
	if( 
		body.name == "TileMap" ||
		body.name == "door" ||
		body.name == "door_y" ||
		body.name == "door_b" ||
		body.name == "door_p"
	):
		touching_wall = true;
		target = null;
		velocity = Vector2(0,0);
		is_moving = false;

func _on_wall_collider_body_exited(body):
	if( body.name == "TileMap" ):
		touching_wall = false;
