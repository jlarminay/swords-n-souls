extends StaticBody2D

onready var LABEL = $Label;

export(int) var kill_count;
export(int) var type = 0;
var open = false;

func _ready():
	if(kill_count>0):
		LABEL.set_text( str(kill_count) );
	else:
		LABEL.set_text('');

func _process(delta):
	if(kill_count>0):
		if(type==0):
			LABEL.set_text( str(kill_count - Global.kills) );
			if(Global.kills >= kill_count && !open):
				open = true;
				$open.play();
		else:
			LABEL.set_text( str(kill_count - Global.kills_boss) );
			if(Global.kills_boss >= kill_count && !open):
				open = true;
				$open.play();


func _on_open_finished():
	queue_free();
