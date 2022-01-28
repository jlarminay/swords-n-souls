extends Area2D

onready var SHRINE = $shrine;
onready var CIRCLE = $circle;

var org;
var active = true;
var dir = 1;
var cur = 0;
var limit = 0.25;

func _ready():
	org = CIRCLE.scale;

func _process(delta):
	if(active):
		cur += dir * (delta/3);
		if(abs(cur)>=limit):
			dir *= -1;
		CIRCLE.scale = org + Vector2(cur,cur);
		SHRINE.modulate = "ffffff";
	else:
		CIRCLE.visible = false;
		SHRINE.modulate = "3f3f3f";


func _on_mini_shrine_body_entered(body):
	if( body.name=="sword" && active ):
		$CPUParticles2D.emitting = true;
		$got.play(0);
		body.healed();
		active = false;
