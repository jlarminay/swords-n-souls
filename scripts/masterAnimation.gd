extends AnimationPlayer

export(NodePath) var sword_path;
var sword;

var played_finished = false;
var played_opening = false;

func _ready():
	sword = get_node(sword_path);
	Music._play("menu");

func _process(delta):
	if(Global.finished && !played_finished):
		played_finished = true;
		play("ending");
	if( !played_opening ):
		played_opening = true;
		play("opening");


func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name=="ending"):
		Global._reset();
		get_tree().change_scene("res://scenes/main.tscn");
		playback_speed = 1;
	if(anim_name=="opening"):
		Global.opening = true;
		Global.health = Global.max_health;
		sword.has_control = true;
		Music._play("game");
		playback_speed = 1;

func _on_skip_pressed():
	playback_speed = 1000;
