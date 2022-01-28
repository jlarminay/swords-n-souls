extends CanvasLayer

onready var KILLS = $hud_hold/pan_kills/kills;

var finished = false;

func _process(delta):
	KILLS.set_text( str( Global.kills ) );
	
	var h = Global.health / Global.max_health * 100;
	$hud_hold/magic.value = h;
	$hud_hold/timer.value = Global.click_timer;
	
	if(Global.health<=0 && !finished):
		finished = true;
		$hud_hold/game_over.visible = true;
		$hud_hold/AnimationPlayer.play("game over");

func _on_Button_pressed():
	Global._reset();
	get_tree().change_scene("res://scenes/main.tscn");

func _on_AnimationPlayer_animation_finished(anim_name):
	print('finished');
