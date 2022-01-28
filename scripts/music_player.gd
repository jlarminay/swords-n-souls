extends Node2D

onready var music = $music;
var music_menu = preload("res://audio/music/menu.wav");
var music_game = preload("res://audio/music/game.wav");
var music_boss = preload("res://audio/music/boss.wav");
var music_victory = preload("res://audio/music/shrine.wav");

var force = false;
var last;
var loop = true;

func _play(type):
	
	if( type=="menu" && (type!=last || force) ):
		last = type;
		music.stream = music_menu;
		music.play();
		loop = true;
		force = false;
		
	if( type=="game" && (type!=last || force) ):
		last = type;
		music.stream = music_game;
		music.play();
		loop = true;
		force = false;
		
	if( type=="boss" && (type!=last || force) ):
		last = type;
		music.stream = music_boss;
		music.play();
		loop = true;
		force = false;
		
	if( type=="victory" && (type!=last || force) ):
		last = type;
		music.stream = music_victory;
		music.play();
		loop = true;
		force = false;


func _on_music_finished():
	if(loop):
		print('loop');
		force = true;
		_play(last);
	else:
		_play("game");
