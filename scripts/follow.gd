extends Sprite

export(NodePath) var target_path;
var target;

func _ready():
	target = get_node(target_path);

func _process(delta):
	global_position = target.global_position;
