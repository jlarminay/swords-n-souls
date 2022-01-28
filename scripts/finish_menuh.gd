extends Node2D

func _ready():
	Music._play("victory");

func _on_menu_pressed():
	get_tree().change_scene("res://scenes/main.tscn");
