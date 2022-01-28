extends Node

var opening = false;
var finished = false;

var kills = 0;
var kills_boss = 0;
var max_health = 100;
var health = 10;

var click_timer = 100;

func _process(delta):	
	#health = 100;
	if(!finished && opening):
		if(health>100):
			health = 100;
		health -= (delta/2);
	else:
		health += delta*30;

func _click_count(delta):
	click_timer += 100 * (delta*1.5);
	if( click_timer > 100 ):
		click_timer = 100;

func _reset():
	opening = false;
	finished = false;
	health = max_health;
	kills = 0;
	click_timer = 100;
