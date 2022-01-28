extends Area2D

onready var SPRITE = $Sprite;

export(int) var type;
var key_y = preload("res://sprites/key_yellow.png");
var key_b = preload("res://sprites/key_blue.png");
var key_p = preload("res://sprites/key_purple.png");

func _ready():
	if( type==1 ):
		SPRITE.texture = key_y;
	elif( type==2 ):
		SPRITE.texture = key_b;
	else:
		SPRITE.texture = key_p;


func _on_key_body_entered(body):
	if( body.name == "sword" ):
		if( type==1 ):
			Global.key_yellow = true;
		elif( type==2 ):
			Global.key_blue = true;
		else:
			Global.key_purple = true;
		queue_free();
