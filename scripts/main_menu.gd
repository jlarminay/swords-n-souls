extends CanvasLayer

func _ready():
	Music._play("menu");

func _on_start_pressed():
	Global._reset();
	get_tree().change_scene("res://scenes/level.tscn");

func _on_how_pressed():
	$pan_playing.visible = true;

func _on_credits_pressed():
	$pan_credits.visible = true;
	
func _on_exit_pressed():
	get_tree().quit();


func _on_close_pressed():
	$pan_playing.visible = false;
	$pan_credits.visible = false;

func _on_link_1_pressed():
	OS.shell_open("https://0x72.itch.io/16x16-dungeon-tileset");

func _on_link_2_pressed():
	OS.shell_open("https://pixel-poem.itch.io/dungeon-assetpuck");

func _on_link_3_pressed():
	OS.shell_open("https://www.1001fonts.com/8-bit-limit-font.html");

func _on_link_4_pressed():
	OS.shell_open("https://www.1001freefonts.com/8-bit-operator.font");

func _on_link_5_pressed():
	OS.shell_open("https://jc-system.itch.io/chiptunesbundle");

func _on_link_6_pressed():
	OS.shell_open("https://cactusdude.itch.io/free-game-soundtrack-by-cactusdude-hurry-up");

func _on_link_7_pressed():
	OS.shell_open("https://forgottendawn.itch.io/royalty-free-legacy-music-pack");


func _on_pulotum_pressed():
	OS.shell_open("https://pulotum.itch.io/");
